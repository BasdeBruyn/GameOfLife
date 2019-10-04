require_relative 'game_controller'
contr = GameController.new
contr.load_board_from_user_input
# contr.load_random_board(15, 15, 30)
contr.start_game(0.5)