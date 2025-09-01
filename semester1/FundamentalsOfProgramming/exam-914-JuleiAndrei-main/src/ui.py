from texttable import *
from src.board import Board,WinException

class UI:
    def __init__(self,board: Board):
        self.board = board
        self.counter = 0

    def print_board(self):
        board=self.board.get_board()
        texttable=Texttable()
        for row in board:
            texttable.add_row(row)

        print(texttable.draw())

    def movement_phase_0(self):
        print("\n")
        print("Movement phase begins!")
        print("\n")
        while True:
            try:
                self.print_board()
                self.board.check_win()
                print("Choose what you want to move:")
                x = int(input("X: "))
                y = int(input("Y: "))
                print("Choose where you want to move:")
                i = int(input("X: "))
                j = int(input("Y: "))
                self.board.movement_phase_human(x, y, i, j,'0')
                self.board.check_win()
                self.board.movement_phase_computer('X')
            except ValueError as ve:
                print(ve)
            except WinException as w:
                self.print_board()
                print(w)
                break

    def movement_phase_X(self):
        print("\n")
        print("Movement phase begins!")
        print("\n")
        while True:
            try:
                self.print_board()
                self.board.check_win()
                print("Choose what you want to move:")
                x=int(input("X: "))
                y=int(input("Y: "))
                print("Choose where you want to move:")
                i=int(input("X: "))
                j=int(input("Y: "))
                self.board.movement_phase_human(x,y,i,j,'X')
                self.board.check_win()
                self.board.movement_phase_computer('0')
            except ValueError as ve:
                print(ve)
            except WinException as w:
                self.print_board()
                print(w)
                break


    #placement
    def start_X(self):
        while True:
            try:
                self.print_board()
                print("Choose coordinates")
                x=int(input("X: "))
                y=int(input("Y: "))
                self.board.mov_human(x,y,'X')
                self.board.check_win()
                self.board.mov_computer('0','X')
                self.board.check_win()
            except ValueError as ve:
                self.counter-=1
                print(ve)
            except WinException as w:
                print(w)
                break
            if self.counter == 3:
                self.board.check_win()
                self.movement_phase_X()
                break
            self.counter += 1

    #placement
    def start_O(self):
        while True:
            try:
                self.board.mov_computer('X','0')
                self.board.check_win()
                self.print_board()
                self.board.check_win()
                print("Choose coordinates")
                x = int(input("X: "))
                y = int(input("Y: "))
                self.board.mov_human(x, y, '0')
                self.board.check_win()
            except ValueError as ve:
                self.counter-=1
                print(ve)
            except WinException as w:
                print(w)
                break
            if self.counter == 3:
                self.board.check_win()
                self.movement_phase_0()
                break
            self.counter += 1

    #placement
    def choose_xor0(self):
        print("X OR 0")
        option=input()
        if option == "X" or option == "x":
            self.start_X()
        elif option == "0":
            self.start_O()
        else:
            raise ValueError("Invalid input")

    #placement
    def run(self):
        while True:
            try:
                self.choose_xor0()
                break
            except ValueError as ve:
                print(ve)
