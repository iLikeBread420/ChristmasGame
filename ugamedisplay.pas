unit ugamedisplay;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SDL2, SDL2_Image;

type
  TGameDisplay = class
    strict private
      has_error: integer;
      window: PSDL_Window;
      renderer: PSDL_Renderer;
      mainViewport: TSDL_Rect;
      playerDot: TSDL_Rect;
    public
      constructor create();
      procedure show();
      destructor destroy(); override;
  end;

implementation

constructor TGameDisplay.create();
begin
  has_error := SDL_Init(SDL_INIT_VIDEO OR SDL_INIT_TIMER OR SDL_INIT_EVENTS OR SDL_INIT_AUDIO);
  has_error := SDL_CreateWindowAndRenderer(0, 0, SDL_WINDOW_FULLSCREEN_DESKTOP, @window, @renderer);

  // Tue so, als waere das Fenster immer 640x480 Pixel gross.
  has_error := SDL_RenderSetLogicalSize(renderer, 1280, 800);

  mainViewport.x := 0; mainViewport.y := 0;
  mainViewport.w := 980; mainViewport.h := 800;
end;

procedure TGameDisplay.show();
begin
  if has_error <> 0 then halt;
  SDL_RenderSetViewport(renderer, @mainViewport);
  SDL_SetRenderDrawColor(renderer, 0, 170, 85, 255);
  SDL_RenderFillRect(renderer, nil);

  SDL_RenderPresent(renderer);
  SDL_Delay(2000);
end;

destructor TGameDisplay.destroy();
begin
  SDL_DestroyRenderer(renderer);
  SDL_DestroyWindow(window);
  SDL_Quit();
  inherited;
end;

end.

