extends Node

## Autoload Singleton: GameState
## Mengelola seluruh parameter status pemain, waktu, uang, dan reputasi NPC.

# Sinyal perubahan status agar UI/HUD otomatis merespons (Event-Driven)
signal stats_changed(energy: int, hunger: int, stress: int, money: int)
signal time_changed(day: int, time_phase: String)
signal quest_flag_changed(flag_name: String, value: bool)
signal reputation_changed(npc_id: String, new_rep: int)

# Fase Waktu dalam 1 Hari
const TIME_PHASES: Array[String] = ["Pagi", "Siang", "Sore", "Malam"]

# Status Pemain
var money: int = 50000 # Modal awal anak rantau: Rp 50.000
var energy: int = 100  # 0 - 100
var hunger: int = 80   # 0 (Kelaparan) - 100 (Kenyang)
var stress: int = 20   # 0 (Santai/Tenang) - 100 (Burnout/Depresi)

# Status Kalender & Waktu
var current_day: int = 1
var current_time_index: int = 0 # 0: Pagi, 1: Siang, 2: Sore, 3: Malam
var debt_target: int = 2500000
var debt_deadline_days: int = 30

# Reputasi NPC Kunci (-100 s.d 100)
var reputation: Dictionary = {
	"bu_wati": 10,
	"cak_man": 20,
	"bayu": 15,
	"saras": 10
}

# Flag Cerita & Quest
var story_flags: Dictionary = {
	"has_talked_to_bu_wati": false,
	"knows_warkop_location": false,
	"cargo_job_done_day_1": false,
	"got_scammed": false
}

func _ready() -> void:
	print("[GameState] GameState Initialized. Modal awal: Rp ", money)


# --- MANAJEMEN STATISTIK PEMAIN ---

func add_money(amount: int) -> void:
	money += amount
	emit_signal("stats_changed", energy, hunger, stress, money)
	print("[GameState] Uang bertambah: Rp ", amount, " | Total: Rp ", money)

func spend_money(amount: int) -> bool:
	if money >= amount:
		money -= amount
		emit_signal("stats_changed", energy, hunger, stress, money)
		print("[GameState] Uang terpakai: Rp ", amount, " | Sisa: Rp ", money)
		return true
	print("[GameState] Uang tidak cukup untuk belanja Rp ", amount)
	return false

func modify_energy(delta: int) -> void:
	energy = clamp(energy + delta, 0, 100)
	emit_signal("stats_changed", energy, hunger, stress, money)

func modify_hunger(delta: int) -> void:
	hunger = clamp(hunger + delta, 0, 100)
	emit_signal("stats_changed", energy, hunger, stress, money)

func modify_stress(delta: int) -> void:
	stress = clamp(stress + delta, 0, 100)
	emit_signal("stats_changed", energy, hunger, stress, money)


# --- MANAJEMEN WAKTU & HARI ---

func get_current_phase_name() -> String:
	return TIME_PHASES[current_time_index]

func advance_time_phase() -> void:
	if current_time_index < TIME_PHASES.size() - 1:
		current_time_index += 1
		# Lapar dan stres meningkat perlahan seiring waktu berjalan
		modify_hunger(-10)
		modify_stress(5)
		emit_signal("time_changed", current_day, get_current_phase_name())
		print("[GameState] Waktu berganti ke: ", get_current_phase_name())
	else:
		print("[GameState] Sudah malam hari. Waktunya kembali ke kos untuk tidur.")

func sleep_and_advance_day() -> void:
	current_day += 1
	current_time_index = 0 # Kembali ke Pagi
	
	# Efek tidur malam: Energi pulih, lapar berkurang
	energy = 100
	modify_hunger(-20)
	modify_stress(-15)
	
	emit_signal("time_changed", current_day, get_current_phase_name())
	emit_signal("stats_changed", energy, hunger, stress, money)
	print("[GameState] Hari berganti! Sekarang Hari ke-", current_day, " (Pagi)")


# --- REPUTASI & FLAG CERITA ---

func set_flag(flag_name: String, value: bool) -> void:
	story_flags[flag_name] = value
	emit_signal("quest_flag_changed", flag_name, value)

func get_flag(flag_name: String) -> bool:
	return story_flags.get(flag_name, false)

func modify_reputation(npc_id: String, delta: int) -> void:
	if reputation.has(npc_id):
		reputation[npc_id] = clamp(reputation[npc_id] + delta, -100, 100)
		emit_signal("reputation_changed", npc_id, reputation[npc_id])
		print("[GameState] Reputasi dengan ", npc_id, ": ", reputation[npc_id])
