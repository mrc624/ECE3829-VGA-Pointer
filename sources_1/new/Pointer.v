`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2024 04:00:18 PM
// Design Name: 
// Module Name: Pointer
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


module Pointer(
    input [9:0] x,
    input [9:0] y,
    output reg on
    );
    parameter POINTER_WIDTH = 8;
    parameter POINTER_HEIGHT = 8;
    
    
    
    always @ (*) begin
        if ( (x > 316 && x <= 324) && (y > 236 && y <= 244) ) begin
            on = 1'b1;
        end else begin
            on = 1'b0;
        end
    end
    
    
    
    
    
    
endmodule
