#include <limits.h>
#include <stdio.h>

#define BIT_32

int main(void) {
#ifdef BIT_32
    printf("short is %I32u bits\n",     CHAR_BIT * sizeof( short )   );
    printf("int is %I32u bits\n",       CHAR_BIT * sizeof( int  )    );
    printf("long is %I32u bits\n",      CHAR_BIT * sizeof( long )    );
    printf("long long is %I32u bits\n", CHAR_BIT * sizeof(long long) );
    printf("pointer is %I32u bits\n", CHAR_BIT * sizeof(void*)       );
#endif
#ifdef BIT_64
    printf("short is %I64u bits\n",     CHAR_BIT * sizeof( short )   );
    printf("int is %I64u bits\n",       CHAR_BIT * sizeof( int  )    );
    printf("long is %I64u bits\n",      CHAR_BIT * sizeof( long )    );
    printf("long long is %I64u bits\n", CHAR_BIT * sizeof(long long) );
    printf("pointer is %I64u bits\n", CHAR_BIT * sizeof(void*)       );
#endif

    return 0;
}
