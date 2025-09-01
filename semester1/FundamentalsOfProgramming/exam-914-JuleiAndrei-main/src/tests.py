import unittest

from board import Board

class TestBoard(unittest.TestCase):
    def test_mov_human(self):
        board = Board()

        board.mov_human(0, 0, 'X')
        self.assertEqual(board.get_board()[0][0], 'X')

        board.mov_human(1, 1, 'X')
        with self.assertRaises(ValueError):
            board.mov_human(1, 1, 'O')

    def test_movement_phase_human(self):
        board = Board()

        board.board[0][0] = 'X'
        board.board[1][0] = ' '

        board.movement_phase_human(0, 0, 1, 0, 'X')
        self.assertEqual(board.get_board()[1][0], 'X')
        self.assertEqual(board.get_board()[0][0], ' ')

if __name__ == '__main__':
    unittest.main()