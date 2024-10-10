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


module Pointer
# (parameter POINTER_WIDTH = 8,
   parameter POINTER_HEIGHT = 8,
   parameter POINTER_MOVE = 8,
   parameter BORDER_X = 640,
   parameter BORDER_Y = 480,
   parameter BORDER_WIDTH = 8
)
(
    input [9:0] x,
    input [9:0] y,
    input clk,
    input btnr,
    input btnl,
    input btnc,
    input btnu,
    input btnb,
    output reg on
    );
    
    reg [9:0] point_x;
    reg [9:0] point_y;
    
    reg  [1:0] r_25MHz;
	wire clk_25MHz;
    
    always @(posedge clk) begin
      r_25MHz <= r_25MHz + 1;
    end
    assign clk_25MHz = (r_25MHz == 0) ? 1 : 0; // assert tick 1/4 of the time
    
    reg btnr_prev;
    reg btnl_prev;
    reg btnc_prev;
    reg btnu_prev;
    reg btnb_prev;
    
    always @ (posedge clk_25MHz) begin
        btnr_prev <= btnr;
        btnl_prev <= btnl;
        btnc_prev <= btnc;
        btnu_prev <= btnu;
        btnb_prev <= btnb;
        if (btnl && !btnl_prev && point_x > (POINTER_MOVE * 2)) begin
            point_x <= point_x - POINTER_MOVE;
        end else if (btnr && !btnr_prev && point_x <(BORDER_X - (POINTER_MOVE * 2) ) ) begin
            point_x <= point_x + POINTER_MOVE;
        end else if (btnb && !btnb_prev && point_y < (BORDER_Y - (POINTER_MOVE * 2)) ) begin
            point_y <= point_y + POINTER_MOVE;
        end else if (btnu && !btnu_prev && point_y > (POINTER_MOVE * 2)) begin
            point_y <= point_y - POINTER_MOVE;
        end else if (btnc && !btnb_prev) begin
            point_y <= (BORDER_Y / 2);
            point_x <= (BORDER_X / 2);
        end
    end
    
    always @ (*) begin
    
        if ( (x > ( point_x - (POINTER_WIDTH / 2) ) 
            && x <= ( point_x + (POINTER_WIDTH / 2) )
            ) 
            && (y > ( point_y - (POINTER_HEIGHT / 2) ) 
            && y <= ( point_y + (POINTER_HEIGHT / 2) ) ) ) 
             begin
            on = 1'b1;
        end else begin
            on = 1'b0;
        end
    end

endmodule

module Debounce(
    input btn,
    output reg debounced
    );
    
    always @ (btn) begin
        debounced <= btn;
    end
    
endmodule