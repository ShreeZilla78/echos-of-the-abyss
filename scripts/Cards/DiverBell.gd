class_name DiverBell
extends Card

func _init():
    card_name = "Diver's Bell"
    description = "Gain 5 Block. If you have no cards in hand, gain an additional 5 Block."
    block = 5

func on_play(player: Player):
    player.gain_block(block)