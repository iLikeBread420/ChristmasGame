program christmas;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, ugamedisplay, uentitydisplay, uentity, uroom, uroomdisplay
  { you can add units after this };

var
  game: TGameDisplay;

begin
  game := TGameDisplay.create;
  game.show();
  game.free;
end.

