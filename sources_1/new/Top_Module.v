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
	input BTNR,
	input BTNL,
	input BTNB,
	input BTNU,
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
    
    wire btnr;
    Debounce deb0 (BTNR, btnr);
    wire btnl;
    Debounce deb1 (BTNL, btnl);
    wire btnu;
    Debounce deb2 (BTNU, btnu);
    wire btnb;
    Debounce deb3 (BTNB, btnb);
    wire btnc;
    Debounce deb4 (reset, btnc);
    
    Pointer pointer(
        .x(x), 
        .y(y), 
        .on(pointer_on),
        .clk(clk_100MHz),
        .btnr(btnr),
        .btnl(btnl),
        .btnc(btnc),
        .btnu(btnu),
        .btnb(btnb)
        );

    Border border(.x(x), .y(y), .on(border_on));

    // Instantiate VGA Controller
    vga_controller vga_c(.clk_100MHz(clk_100MHz), .reset(), .hsync(hsync), .vsync(vsync),
                         .video_on(video_on), .p_tick(), .x(x), .y(y));
    // RGB Buffer
    always @(posedge clk_100MHz)
    if (pointer_on) begin
        rgb_reg <= WHITE;
    end else if (border_on) begin
        rgb_reg <= RED;;
    end else begin
       rgb_reg <= sw;
    end
    // Output
    assign rgb = (video_on) ? rgb_reg : 12'b0;   // while in display area RGB color = sw, else all OFF
        
endmodule
