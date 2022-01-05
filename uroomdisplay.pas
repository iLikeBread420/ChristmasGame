unit uroomdisplay;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SDL2, SDL2_image, URoom;

type
  TRoomDisplay = class
    strict private
      renderer: PSDL_Renderer;
      room: TRoom;
      bgTexture: PSDL_Texture;
      rect: TSDL_Rect;
    public
      constructor create(rend: PSDL_Renderer; rm: TRoom; width: integer; height: integer);
      procedure draw();
      destructor destroy(); override;
  end;

implementation

constructor TRoomDisplay.create(rend: PSDL_Renderer; rm: TRoom; width: integer; height: integer);
begin
  renderer := rend;
  room := rm;
  case (room.getKindOfRoom) of
  RM_INSIDE: bgTexture := IMG_LoadTexture(renderer, PChar('assets\Background.Room.1_downscaled.png'));
  RM_OUTSIDE: bgTexture := IMG_LoadTexture(renderer, PChar('assets\Background.Outside_downscaled.png'));
  end;
  rect.x := 0;
  rect.y := 0;
  rect.w := width;
  rect.h := height;
end;

procedure TRoomDisplay.draw();
begin
  // TODO render entities
  SDL_RenderCopy(renderer, bgTexture, nil, @rect);
end;

destructor TRoomDisplay.destroy();
begin
  SDL_DestroyTexture(bgTexture);
end;

end.

