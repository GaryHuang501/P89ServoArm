@echo off
::This file was created automatically by crosside to compile with C51.
D:
cd "\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\"
"C:\Program Files (x86)\CrossIDE\Call51\Bin\c51.exe" --use-stdout  "D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c"
if not exist hex2mif.exe goto done
if exist main.ihx hex2mif main.ihx
if exist main.hex hex2mif main.hex
:done
echo done
echo Crosside_Action Set_Hex_File D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.hex
