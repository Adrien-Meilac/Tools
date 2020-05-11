#include <cstdio>
#include <windows.h>

#pragma execution_character_set( "utf-8" )

int main()
{
    SetConsoleOutputCP( 65001 );
    printf( "Testing unicode -- English -- Ελληνικά -- Español -- Русский. aäbcdefghijklmnoöpqrsßtuüvwxyz\n" );
}