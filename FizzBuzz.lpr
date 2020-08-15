program FizzBuzz;

uses
 sysutils;
var
  ActionNum: array [1..65536] of integer;
  ReactionString: array [1..65536] of string;
  TempFileOutput, TargetFile: textfile;
  ErrorReport, filename, choiceInput, consoleLog, confirm: string;
  //fileLength
  Length, outputNum, writeNum, counter,
  choice,
  //choice 0 for main 1 read file, 2 create file, 3 FizzBuzz, 4 exit
  confirmChoice: integer;
  Success, exit, continue, isEmpty, confirmName: boolean;

procedure ExitConfirm;
 begin
   writeln('Are you sure you want to exit this executable? Type [y] to confirm, press Enter to cancel.');
   readln(choiceInput);
   case (choiceInput) of
     'y', 'Y', 'YES', 'yes', 'Yes', 'confirm', 'Confirm', 'CONFIRM': begin
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
    writeln('Please input the last integer.');
    readln(Length);
    while Length<=0 do
     begin
      writeln('Please input the last number again, which should be bigger than 0.');
      readln(Length);
     end;
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
    exit:=false
   end;
 end;
procedure ReadFile;
 begin
  confirmName:=false;
  while confirmName=false do
   begin
    writeln('Please input the name of your file. No need to include the ".txt" after the name even if you see it.');
    readln(filename);
    writeln('Type [y] to confirm the file name, "', filename, '", else press Enter to retry.');
    readln(confirm);
    case (confirm) of
      'y', 'Y', 'Yes', 'YES': confirmName:=true
    end;
   end;
  filename:=filename+'.txt';
  assignfile(TargetFile, filename);
  try
    reset(TargetFile);
    counter:=1;
    while not eof(TargetFile) do
      begin
        readln(TargetFile, ActionNum[counter]);
        readln(TargetFile, ReactionString[counter]);
        readln;
        counter:=counter+1;
      end;
    CloseFile(TargetFile);
    writeln('File reading successful!');
    write('File length:');
    writeln(counter);
    success:=true;
    confirmChoice:=0;
    while confirmChoice=0 do
      begin
      writeln('Do you wish to confirm the file content? Please type [yes] if you wish to confirm, and [no] if you would like to skip this confirmation.');
      readln(confirm);
      case (confirm) of
      'yes', 'y', 'Yes', 'Y', 'YES': confirmChoice:=1;
      'no', 'n', 'No', 'N', 'NO': confirmChoice:=2;
      end;
      end;
      if confirmChoice=1 then
      begin
       writeln('');
       writeln('********************');
      for writeNum:= 1 to counter do
        begin
         writeln(ActionNum[writeNum]);
         writeln(ReactionString[writeNum]);
        end;
      writeln('********************');
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
  exit:=false
 end;
procedure MakeFile;
 begin
  writeln('Welcome to the FizzBuzz file creator!');
  while continue=false do
   begin
     readln;
   end;
  exit:=false
 end;
procedure Selector;
 begin
  writeln('**********Advanced FizzBuzz**********');
  writeln('');
  writeln('Type [1] to Read a file');
  writeln('');
  writeln('Type [2] to create a new file');
  writeln('');
  writeln('Type [3] to run FizzBuzz');
  writeln('');
  writeln('Type [4] to exit this executable');
  writeln('');
  writeln('*************************************');
  readln(choiceInput);
  writeln('');
  case (choiceInput) of
  '1': ReadFile;
  '2': MakeFile;
  '3': RunProgram;
  '4': ExitConfirm;
  end;
 end;
begin
  writeln('Please read the "LICENSE.txt" file before proceeding.');
  writeln('');
  while exit=false do Selector;
end.
