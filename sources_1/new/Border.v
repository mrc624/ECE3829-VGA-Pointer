`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2024 07:25:39 PM
// Design Name: 
// Module Name: Border
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


module Border(
    input [9:0] x,
    input [9:0] y,
    output reg on
    );
    parameter BORDER_X = 640;
    parameter BORDER_WIDTH = 8;
    
    parameter BORDER_LEFT_STOP = BORDER_WIDTH;
    parameter BORDER_RIGHT_START = BORDER_X - BORDER_WIDTH;
    
    parameter BORDER_Y = 480;
    
    parameter BORDER_TOP_STOP = BORDER_WIDTH;
    parameter BORDER_BOTTOM_START = BORDER_Y - BORDER_WIDTH;
    
    //assign x = ( (x >= BORDER_X_MIN && x <= BORDER_X_LEFT) || (x >= BORDER_X_RIGHT && BORDER_X_MAX <= x) ) ? 1'b1 : 1'b0;
    
    always @ (*) begin
        //x
        if (x < BORDER_LEFT_STOP) begin
            on = 1'b1;
        end else if (x > BORDER_RIGHT_START) begin
            on = 1'b1;
        end
        //y
        else if (y < BORDER_TOP_STOP) begin
            on = 1'b1;
        end else if (y > BORDER_BOTTOM_START) begin
            on = 1'b1;
        end
        //off
        else begin
            on = 1'b0;
        end
    end
    
endmodule
