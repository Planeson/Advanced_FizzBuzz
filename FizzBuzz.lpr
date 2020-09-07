program FizzBuzz;

uses
 sysutils;

type
  TActionNum = array [1..65536] of integer;
  TReactionString = array [1..65536] of string;

var
  ActionNum: TActionNum;
  ReactionString:TReactionString;
  TargetFile, OutputFile: textfile;
  filename, choiceInput, consoleLog, confirm, tempInput, writeString: string;
  Length, outputNum, writeNum, counter, confirmChoice, tempActionNum: integer;
  Success, exit, continue, isEmpty, confirmName, corNum, writeLoop, numCheck: boolean;

procedure ArrayClear;
begin
 ActionNum:=default(TActionNum);
 ReactionString:=default(TReactionString);
end;

procedure ExitConfirm;
 begin
   writeln('Are you sure you want to exit this executable? Type [y] to confirm, press Enter to cancel.');
   writeln;
   readln(choiceInput);
   case (choiceInput) of
     'y', 'Y', 'YES', 'yes', 'Yes', 'confirm', 'Confirm', 'CONFIRM': begin
            writeln;
            writeln('See you next time and have a nice day! Press Enter to exit.');
            readln;
            exit:=true;
            end;
   end;
 end;
procedure RunProgram;
 begin
  if counter<>0 then
   begin
    writeln('*************************************');
    writeln;
    writeln('Please input the last integer.');
    writeln;
    readln(length);
    while Length<=0 do
     begin
      writeln('Please input the last number again, which should be bigger than 0.');
      readln(Length);
     end;
    writeln;
    writeln('*************************************');
    writeln;
    for outputNum:= 1 to Length do
      begin
      consoleLog:='';
        for writeNum:= 1 to counter do
         begin
          if ActionNum[writeNum]<>0then
          if (outputNum mod ActionNum[writeNum])=0 then
          consoleLog:=consoleLog+ReactionString[writeNum];
         end;
        if consoleLog='' then consoleLog:=intToStr(outputNum);
        writeln(consoleLog);
      end;
    writeln;
    writeln('*************************************');
    writeln;
    writeln('FizzBuzz finished!');
   end
  else writeln('Please read ormake a file before usig this segment!')
 end;
procedure ReadFile;
 begin
  ArrayClear;
  confirmName:=false;
  writeln('*************************************');
  writeln;
  while confirmName=false do
   begin
    writeln('Please input the name of your file. No need to include the ".txt" after the name even if you see it.');
    writeln;
    readln(filename);
    writeln;
    filename:=filename+'.txt';
    if FileExists(filename) then confirmName:=true
      else begin
        writeln('This file seems to not exist!');
        writeln;
        writeln('Make sure the file is located in the same folder at this executable and you typed the correct name.');
        writeln;
        writeln('Please try again.');
        writeln;
           end;
    end;
   assignfile(TargetFile, filename);
   try
    reset(TargetFile);
    counter:=1;
    while not eof(TargetFile) do
      begin
        readln(TargetFile, tempInput);
        if tempInput<>'' then
         begin
           corNum:=TryStrToInt(tempInput, ActionNum[counter]);
           if NOT corNum then writeln('Something went wrong! ', tempInput, ' doesn''t seem like a number!')
           end;
        readln(TargetFile, tempInput);
        if tempInput<>'' then ReactionString[counter]:=tempInput;
        counter:=counter+1;
      end;
    CloseFile(TargetFile);
    writeln('*************************************');
    writeln;
    writeln('File reading successful!');
    writeln;
    write('File length:');
    writeln(counter-1);
    writeln;
    success:=true;
    confirmChoice:=0;
    while confirmChoice=0 do
      begin
      writeln('Do you wish to confirm the file content? Please type [yes] if you wish to confirm, and [no] if you would like to skip this confirmation.');
      writeln;
      readln(confirm);
      case (confirm) of
      'yes', 'y', 'Yes', 'Y', 'YES': confirmChoice:=1;
      'no', 'n', 'No', 'N', 'NO': confirmChoice:=2;
      end;
      end;
      if confirmChoice=1 then
      begin
       writeln;
       writeln('*************************************');
      for writeNum:= 1 to counter-1 do
        begin
         writeln(ActionNum[writeNum]);
         writeln(ReactionString[writeNum]);
        end;
      writeln('********************');
      writeln;
      writeln('End of file. Press enter to continue.');
      readln;
      isEmpty:=false;
      end;
  except
    on E: EInOutError do
    begin
       writeln('File handling error occurred. Details: ', E.Message);
       success:=false;
    end;
  end;
 end;
procedure MakeFile;
 begin
  ArrayClear;
  writeln('Welcome to the FizzBuzz file creator!');
  writeln('Note that creating a file overrides the file stored in memory. You will need to load it back up if you wish to use it.');
  Counter:=0;
  writeLoop:=true;
  while writeLoop=true do
    begin
    Counter:=Counter+1;
      numCheck:=false;
      writeln('Type in the number.');
      while numCheck=false do
        begin
          readln(writeString);
          writeln;
          if TryStrToInt (writeString, tempActionNum)
          then if tempActionNum>0 then begin
                                          ActionNum[Counter]:=tempActionNum;
                                          numCheck:=true;
                                       end
               else writeln('Less than or equal to 0! Please type in a number larger than 0!')
          else writeln('Your input ''', writeString, ''' seems to not be a number! Please type in a number!')
        end;
      writeln('Type in the string.');
      readln(writeString);
      ReactionString[Counter]:=writeString;
      writeln('Press Enter to continue writing, type anything else to leave.');
      readln(choiceInput);
      if choiceInput<>'' then
        begin
          choiceInput:='';
          writeln('Press Enter to confirm exiting, type anything else to continue writing.');
          readln(choiceInput);
          if choiceInput='' then writeLoop:=false;
        end;
    end;
   end;
procedure Selector;
 begin
  writeln;
  writeln('**********Advanced FizzBuzz**********');
  writeln;
  writeln('Type [1] to Read a file');
  writeln;
  writeln('Type [2] to create a new or edit an existing file');
  writeln;
  writeln('Type [3] to run FizzBuzz');
  writeln;
  writeln('Type [4] to exit this executable');
  writeln;
  writeln('*************************************');
  writeln;
  continue:=false;
  while continue=false do
    begin
      continue:=true;
      readln(choiceInput);
      writeln;
      case (choiceInput) of
      '1': ReadFile;
      '2': MakeFile;
      '3': RunProgram;
      '4': ExitConfirm;
      else
        begin
          writeln('Please choose a segment to run!');
          continue:=false
        end;
    end;
 end;
end;
begin
  writeln('Please read the "LICENSE.txt" file before proceeding.');
  exit:=false;
  while exit=false do Selector;
end.
