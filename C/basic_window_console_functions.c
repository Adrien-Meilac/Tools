#include <windows.h>
#include <tchar.h>
#include <stdio.h>

void Color(int flags)
{
    HANDLE H=GetStdHandle(STD_OUTPUT_HANDLE);
    SetConsoleTextAttribute(H,(WORD)flags);
}

void Locate(int x,int y)
{
    HANDLE H=GetStdHandle(STD_OUTPUT_HANDLE);
    COORD C;
    C.X=(SHORT)x;
    C.Y=(SHORT)y;
    SetConsoleCursorPosition(H,C);
}


int main()
{
    SetConsoleTitle(_T("Plouf"));
    Color(FOREGROUND_BLUE|FOREGROUND_INTENSITY);
    printf("Test\n");
    Locate(35,6);
    Color(FOREGROUND_RED|FOREGROUND_INTENSITY|BACKGROUND_GREEN);
    printf("ReTest\n");
    return 0;
}
