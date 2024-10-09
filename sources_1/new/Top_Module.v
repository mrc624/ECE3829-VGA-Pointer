`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2024 04:24:17 PM
// Design Name: 
// Module Name: Top_Module
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

module Top(
	input clk_100MHz,      // from Basys 3
	input reset,
	input [11:0] sw,       // 12 bits for color
	output hsync, 
	output vsync,
	output [11:0] rgb      // 12 FPGA pins for RGB(4 per color)
	//following for testing
	,
	output [6:0] seg_out,
	output [3:0] an_out
);
	
	parameter RED   = 12'b0000_0000_1111;
	parameter WHITE = 12'b1111_1111_1111;
	
	// Signal Declaration
	reg [11:0] rgb_reg;    // register for Basys 3 12-bit RGB DAC 
	wire video_on;         // Same signal as in controller
    wire [9:0] x;
    wire [9:0] y;
    wire border_on;
    wire pointer_on;
    
    Pointer pointer(.x(x), .y(y), .on(pointer_on));

    Border border(.x(x), .y(y), .on(border_on));

    // Instantiate VGA Controller
    vga_controller vga_c(.clk_100MHz(clk_100MHz), .reset(reset), .hsync(hsync), .vsync(vsync),
                         .video_on(video_on), .p_tick(), .x(x), .y(y));
    // RGB Buffer
    always @(posedge clk_100MHz or posedge reset)
    if (reset) begin
       rgb_reg <= 0;
    end else if (pointer_on) begin
        rgb_reg <= WHITE;
    end else if (border_on) begin
        rgb_reg <= RED;;
    end else begin
       rgb_reg <= sw;
    end
    // Output
    assign rgb = (video_on) ? rgb_reg : 12'b0;   // while in display area RGB color = sw, else all OFF
        
endmodule
