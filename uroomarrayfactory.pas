unit uroomarrayfactory;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, URoom;

type
  // Nur eine Wrapper-Klasse fuer das korrekte Erstellen der Raeume.
  TRoomArrayFactory = class
    strict private
      rooms: array[0..6] of TRoom;
    public
      constructor create();
      procedure retrieveRooms();
  end;

implementation

constructor TRoomArrayFactory.create();
begin

end;

end.

