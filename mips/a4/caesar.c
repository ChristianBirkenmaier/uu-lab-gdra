#include <stdio.h>

char line[80];

char caesar_helper(char c, int distance, char base)
{
    c -= base;
    c += distance+26;
    c %= 26;
    c += base;
    return c;
}

char caesar_char(char c, int distance)
{
    if ('a' <= c && c <= 'z')
    {
        return caesar_helper(c, distance, 'a');
    }
    else if ('A' <= c && c <= 'Z')
    {
        return caesar_helper(c, distance, 'A');
    }
    return c;
}

void caesar_line(char *buffer, int distance)
{
    char *start_of_line = buffer;

    while (*buffer != 0)
    {
        *buffer = caesar_char(*buffer, distance);
        buffer++;
    }

    printf("%s\n", start_of_line);
}

int main()
{

    printf("Enter a line: ");

    fgets(line, 80, stdin);
    caesar_line(line, 1);
    caesar_line(line, 2);
    caesar_line(line, 3);
    caesar_line(line, 4);
    caesar_line(line, 5);
    caesar_line(line, 6);
    caesar_line(line, 7);
    caesar_line(line, -2);

    caesar_line(line, 13);
    caesar_line(line, 13);
    return 0;
}