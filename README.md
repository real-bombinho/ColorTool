# ColorTool
Popup for easier debugging of colour issues in delphi

This little tool has been created to be able to visually track colours on conversion.

Main method is tool.ShowColor(const color: TAlphaColor; const message: string = '');

It is overloaded with a similar TColor method allowing to be called regardless the colour format.
A window displaying the colour and numeric values is created. A number of Windows Colour Schemes are
available via right click on the colour sample to change system colours.
The string can be used to identify popups from different calling positions.
