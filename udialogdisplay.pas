unit udialogdisplay;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SDL2, SDL2_ttf, SDL2_image;

type
  TDialogDisplay = class
    strict private
      renderer: PSDL_Renderer;
      all_width: integer;
      all_height: integer;
      width: integer;
      height: integer;
      roomIndex: integer;
      lineIndex: integer;
      dialog: array [0..5] of array of string;
      surfaceArray: array [0..5] of array of PSDL_Surface;
      textureArray: array [0..5] of array of PSDL_Texture;
      bgTexture: PSDL_Texture;
      rect: TSDL_Rect;
    public
      constructor create(rendr: PSDL_Renderer; all_w: integer; all_h: integer);  // Gesamtabmessungen des Spielfensters
      procedure setCursor(room: integer; index: integer);
      procedure draw();
  end;

implementation

constructor TDialogDisplay.create(rendr: PSDL_Renderer; all_w: integer; all_h: integer);
var
  i, j: integer;
  font: PTTF_Font;
  fgColor: TSDL_Color;
  bgColor: uint32;
  bgSurface: PSDL_Surface;
begin
  renderer := rendr;
  all_width := all_w;
  all_height := all_h;
  width := 300;
  height := 200;
  // Notiz: Dieser Code sollte spaeter durch eine Methode zum Laden des Texts aus einer Datei ersetzt werden.
  SetLength(dialog[0], 3);
  dialog[0][0] := 'Es war ein langer Tag. Jetzt sind die Geschenke fuer alle Kinder der Welt vorbereitet. Es waere viel schneller gewesen, wenn der nervige Elf sich nun konzentrieren koennte, um die Wunschlisten rechtzeitig zu organisieren. ';
  dialog[0][1] := 'Er sprach staendig von einer Verschwoerung, einem gruenen Mann, der Weihnachten zerstoeren will. Wir muessen wieder das Trinken der gruenen Saefte am Arbeitsplatz verbieten!';
  dialog[0][2] := 'Vielleicht sollte ich mal nach meinen Mitarbeitern sehen, Sie werden sehr schnell frech, wenn ich nicht da bin.';
  SetLength(dialog[1], 5);
  dialog[1][0] := 'MC: Was ist hier passiert, wo sind alle???!!!!';
  dialog[1][1] := 'Lazy Elf: Ein gruenes Monster ist in das Gebaeude eingedrungen, es hat die Elfen entfuehrt und sie hypnotisiert, wir muessen sie retten!!!';
  dialog[1][2] := 'MC: Was ist mit den Geschenken?';
  dialog[1][3] := 'Lazy Elf: Sie wurden auch gestohlen, ich konnte nichts dagegen tun.';
  dialog[1][4] := 'MC: Du bleibst hier, ich werde Weihnachten retten!!! Ich muss den Weihnachtsmann stolz auf mich machen, er hat so sehr an mich geglaubt, dass er mir dieses Weihnachten ueberlassen hat, ich kann ihn nicht enttaeuschen.';
  SetLength(dialog[2], 0);
  SetLength(dialog[3], 0);
  SetLength(dialog[4], 0);
  SetLength(dialog[5], 9);
  dialog[5][0] := 'MC: Da bist du Monster!!! Du wirst mir jetzt nicht entkommen!!! Zeig mir dein Gesicht du gruener Muffin.';
  dialog[5][1] := 'Monster: *takes of the mask*';
  dialog[5][2] := 'MC: Der Weinachtsmann??? Warum versuchst du Weinachten zu zerstoeren?';
  dialog[5][3] := 'Weinachtsmann: Es geht staendig darum, wo der Weihnachtsmann ist und nie darum, wie dem Weihnachtsmann geht. Ich verbringe jedes Weihnachten damit, ein Laecheln auf die Gesichter der Kinder zu zaubern.';
  dialog[5][4] := 'Ich sorge dafuer, dass sich jeder von ihnen waehrend der Weihnachtszeit wertgeschaetzt fuehlt, und was bekomme ich fuer meine harte Arbeit?!! Gar nichts!!';
  dialog[5][5] := 'Frueher haben mir die Kinder immer Kekse und Milch auf den Tisch gestellt, aber heutzutage bekomme ich nichts mehr. Sie haben mich vergessen, und denken stattdessen nur an die Geschenke!!!';
  dialog[5][6] := 'An Weihnachten ging es nie um die Geschenke, sondern um gegenseitige Wertschaetzung und Liebe!';
  dialog[5][7] := 'MC: Ich wusste nicht, dass du dich die ganze Zeit so gefuehlt hast. Aber Weinachstmann, wir koennten all das wieder richtig machen! Wir koennten zusammen arbeiten und Weinachten zusammen retten.';
  dialog[5][8] := 'Weinachtsmann:  Ich glaube du hast recht. Wir schaffen es, zusammen!!!';

  roomIndex := 0;
  lineIndex := 0;

  // SDL2_ttf initialisieren
  TTF_Init();
  font := TTF_OpenFont('C:\WINDOWS\fonts\Arial.ttf', 18);
  fgColor.r := 0; fgColor.g := 0; fgColor.b := 0;

  for i := 0 to 5 do
  begin
    SetLength(surfaceArray[i], Length(dialog[i]));
    SetLength(textureArray[i], Length(dialog[i]));
    for j := 0 to (Length(dialog[i]) - 1) do
    begin
      surfaceArray[i][j] := TTF_RenderText_Blended_Wrapped(font, PChar(dialog[i][j]), fgColor, width - 50);
      textureArray[i][j] := SDL_CreateTextureFromSurface(renderer, surfaceArray[i][j]);
    end;
  end;

  rect.x := all_width - width;
  rect.y := 0;
  rect.w := width;
  rect.h := height;

  bgTexture := IMG_LoadTexture(renderer, PChar('assets\white.jpg'));
end;

procedure TDialogDisplay.setCursor(room: integer; index: integer);
begin
  roomIndex := room;
  lineIndex := index;
end;

procedure TDialogDisplay.draw();
begin
  SDL_RenderCopy(renderer, bgTexture, nil, @rect);
  SDL_RenderCopy(renderer, textureArray[roomIndex][lineIndex], nil, @rect);
end;

end.

