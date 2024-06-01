`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/16 23:32:43
// Design Name: 
// Module Name: Decoder_all
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Decoder_all(
	input [15:0] inData,
	output [27:0] outData
    );
    Decoder Decoder1(.num(inData[3:0]), .code(outData[27:21]));
    Decoder Decoder2(.num(inData[7:4]), .code(outData[20:14]));
    Decoder Decoder3(.num(inData[11:8]), .code(outData[13:7]));
    Decoder Decoder4(.num(inData[15:12]), .code(outData[6:0]));
endmodule
