from random import randint

class WinException(Exception):
    pass

class Board:
    def __init__(self):
        self.board=[[' ' for _ in range(3)] for _ in range(3)]
        self.index=0

    def get_board(self):
        return self.board

    def movement_phase_human(self,x,y,i,j,sign):
        """
        Moves the sign to an empty cell
        :param x: sign coordinate
        :param y: sign coordinate
        :param i: empty cell index
        :param j: empty cell index
        :param sign: sign of human
        :return: None
        """
        if x>2 or x<0 or y>2 or y<0:
            raise ValueError("Invalid coordinates")
        if j>2 or j<0 or i>2 or i<0:
            raise ValueError("Invalid coordinates")

        if not self.board[x][y]==sign:
            raise ValueError("You must choose to move your own coordinates")

        if self.board[i][j] != ' ':
            raise ValueError("You can only move to an empty cell")

        moves=[(1,0),(0,1),(-1,0),(0,-1),(1,1),(-1,-1),(-1,1),(1,-1)]
        ok=False
        for move in moves:
            if x+move[0] <3 and y+move[1] <3 and x+move[0]>=0 and y+move[1]>= 0:
                if x+move[0] == i and y+move[1] == j:
                    self.board[x][y], self.board[i][j] = self.board[i][j], self.board[x][y]
                    return
        raise ValueError("You can only move to an neighbour cell")

    def movement_phase_computer(self,sign):
        """
        Moves the sign to an empty cell
        :param sign: computer sign
        :return: None
        """
        space_x=None
        space_y=None
        for i in range(0,3):
            for j in range(0,3):
                if self.board[i][j] == ' ':
                    space_x=i
                    space_y=j
                    break

        moves=[(1,0),(0,1),(-1,0),(0,-1),(1,1),(-1,-1),(-1,1),(1,-1)]
        for move in moves:
            if space_x+move[0]>=0 and space_y+move[1]>=0 and space_x+move[0]<3 and space_y+move[1]<3:
                if self.board[space_x+move[0]][space_y+move[1]] == sign:
                    self.board[space_x+move[0]][space_y+move[1]],self.board[space_x][space_y]=self.board[space_x][space_y],self.board[space_x+move[0]][space_y+move[1]]


    def check_win(self):
        """
        Checks if the computer/human has won
        :return: None
        """
        for i in range(0,3):
            j=0
            if self.board[i][j]==self.board[i][j+1]==self.board[i][j+2] and self.board[i][j]!=' ':
                raise WinException(f"{self.board[i][j]} Won")

        for j in range(0,3):
            i=0
            if self.board[i][j]==self.board[i+1][j]==self.board[i+2][j] and self.board[i][j]!=' ':
                raise WinException(f"{self.board[i][j]} Won")
        for i in range(0,3):
            if i==0:
                if self.board[i][i]==self.board[i+1][i+1]==self.board[i+2][i+2] and self.board[i][i]!=' ':
                    raise WinException(f"{self.board[i][i]} Won")
            if i==2:
                if self.board[i][i]==self.board[i-1][i-1]==self.board[i-2][i-2] and self.board[i][i]!=' ':
                    raise WinException(f"{self.board[i+1][i]} Won")

    def mov_human(self,x,y,sign):
        """
        Places the sign into an empty cell
        :param x: sign coordinate
        :param y: sign coordinate
        :param sign: human sign
        :return: None
        """
        if x>2 or x<0 or y>2 or y<0:
            raise ValueError("Invalid coordinates")
        if self.board[x][y] == ' ':
            self.board[x][y] = sign
        else:
            raise ValueError("Invalid move")



    def mov_computer(self,sign,sign_human):
        """
        Places the sign into an empty cell that is either random or that blocks the
        :param sign:
        :param sign_human:
        :return:
        """
        for i in range(0,3):
            if self.board[i][0]==self.board[i][1]==sign_human and self.board[i][2]==' ':
                self.board[i][2]=sign
                return
            if self.board[i][1]==self.board[i][2]==sign_human and self.board[i][0]==' ':
                self.board[i][0]=sign
                return
            if self.board[i][2]==self.board[i][0]==sign_human and self.board[i][1]==' ':
                self.board[i][1]=sign
                return

        for i in range(0,3):
            if self.board[0][i]==self.board[1][i]==sign_human and self.board[2][i]==' ':
                self.board[2][i]=sign
                return
            if self.board[1][i]==self.board[2][i]==sign_human and self.board[0][i]==' ':
                self.board[0][i]=sign
                return
            if self.board[0][i]==self.board[2][i]==sign_human and self.board[1][i]==' ':
                self.board[1][i]=sign
                return
        i=0

        if self.board[i][i]==self.board[i+1][i+1]==sign_human and self.board[i+2][i+2]==' ':
            self.board[i+2][i+2]=sign
            return
        if self.board[i+1][i+1]==self.board[i+2][i+2]==sign_human and self.board[i][i]==' ':
            self.board[i][i]=sign
            return
        if self.board[i][i]==self.board[i+2][i+2]==sign_human and self.board[i+1][i+1]==' ':
            self.board[i+1][i+1]=sign
            return

        if self.board[0][2]==self.board[1][1]==sign_human and self.board[2][0]==' ':
            self.board[2][0]=sign
            return
        if self.board[1][1]==self.board[2][0]==sign_human and self.board[0][2]==' ':
            self.board[0][2]=sign
            return
        if self.board[2][0]==self.board[0][2]==sign_human and self.board[1][1]==' ':
            self.board[1][1]=sign
            return

        self.mov_computer_random(sign)

    def mov_computer_random(self,sign):
        x = randint(0, 2)
        y = randint(0, 2)
        while self.board[x][y] != ' ':
            x = randint(0, 2)
            y = randint(0, 2)
        self.board[x][y] = sign
