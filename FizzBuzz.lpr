program FizzBuzz;

uses
 sysutils;

const
  CLicensingFileName='LICENSE.txt';
var
  ActionNum: array [1..65536] of integer;
  ReactionString: array [1..65536] of string;
  TempFileOutput, TargetFile: textfile;
  ErrorReport, filename, choiceInput, consoleLog, confirm: string;
  //fileLength
  Length, readNum, outputNum, writeNum, counter,
  choice,
  //choice: 1 read file, 2 create file, 3 exit, 4 FizzBuzz
  confirmChoice: integer;
  Success, continue: boolean;

begin
AssignFile(TempFileOutput, CLicensingFileName);
//error-catching exception
{$I+}
//embed the file creation in a try/except block to handle errors "peacefully"
try
  //creating the file
  rewrite(TempFileOutput);
  //writing the license
  writeln(TempFileOutput, 'Copyright 2020 Carson Cheung(Planeson P.)');
  writeln(TempFileOutput, '');
  writeln(TempFileOutput, 'Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated');
  writeln(TempFileOutput, 'documentation files (the "Software"), to deal in the Software without restriction, including without limitation');
  writeln(TempFileOutput, 'the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and');
  writeln(TempFileOutput, 'to permit persons to whom the Software is furnished to do so, subject to the following conditions:');
  writeln(TempFileOutput, '');
  writeln(TempFileOutput, 'The above copyright notice and this permission notice shall be included in all copies or substantial portions of');
  writeln(TempFileOutput, 'the Software.');
  writeln(TempFileOutput, '');
  writeln(TempFileOutput, 'THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO');
  writeln(TempFileOutput, 'THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE');
  writeln(TempFileOutput, 'AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF');
  writeln(TempFileOutput, 'CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER');
  write(TempFileOutput, 'DEALINGS IN THE SOFTWARE.');
  //close to file to free up the memory and prevent memory leaks
  CloseFile(TempFileOutput);
except
  //error reporting for the LICENSE.txt file
  on E: EInOutError do
    begin
      ErrorReport:=('File handling error occurred. Undone is forced to quit. Details: '+E.ClassName+'/'+E.Message+' you should try launch this app as an administrator or put it somewhere like the desktop where you do not need permission to run this application executable.');
      writeln('Undone File Writing Error', ErrorReport);
    end;
end;
writeln('Please read the "LICENSE.txt" file before proceeding.');
choice:=0;
while (choice=0) do
begin
  writeln('Do you already have a file to load up or need to create a new one? Type [yes] if you do have a file and [no] if you do not, and press enter afterwards.');
  readln(choiceInput);
  case (choiceInput) of
  'yes', 'y', 'Yes', 'Y', 'YES': choice:=1;
  'no', 'n', 'No', 'N', 'NO': choice:=2;
  else choice:=0;
  end;
//end;
while choice=1 do
 begin
  writeln('Please input the name of your file. No need to include the ".txt" after the name even if you see it.');
  readln(filename);
  filename:=filename+'.txt';
  assignfile(TargetFile, filename);
  try
    reset(TargetFile);
    counter:=1;
    while not eof(TargetFile) do
      begin
        readln(TargetFile, ActionNum[counter]);
        readln(TargetFile, ReactionString[counter]);
        counter:=counter+1;
      end;
    ActionNum[counter]:=''
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
      for writeNum:= 1 to counter do
        begin
         writeln(ActionNum[writeNum]);
         writeln(ReactionString[writeNum]);
        end;
      writeln('End of file. Press enter to continue.');
      readln;
      end;
  except
    on E: EInOutError do
    begin
       writeln('File handling error occurred. Details: ', E.Message);
       success:=false;
    end;
  end;
  if choice=4 then begin
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
  end;
  writeln('Type [exit] to exit the program, or [restart] to restart the program.');
  readln(choiceInput);
  case(choiceInput) of
  'exit', 'e', 'E', 'Exit', 'EXIT': choice:=3;
  'restart', 'r', 'R', 'Restart', 'RESTART':choice:=0;
  //Not sure if I will reuse, this is too messy
  //'create', 'c', 'C', 'Create', 'CREATE':choice:=2
  end;
 end;
   while choice=2 do
    begin
     writeln('Welcome to the FizzBuzz file creator!');
     while continue=false do
      begin
        readln;
      end;
    end;
end;
end.


