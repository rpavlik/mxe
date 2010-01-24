/* This file is part of mingw-cross-env.                     */
/* See doc/index.html or doc/README for further information. */

#include <SDL.h>

int main(int argc, char* argv[])
{
    SDL_Surface *screen;

    (void)argc;
    (void)argv;

    if (SDL_Init(SDL_INIT_EVERYTHING) < 0) return 1;

    screen = SDL_SetVideoMode(640, 480, 32, SDL_HWSURFACE);

    SDL_Quit();
    return 0;
}