/*
 * This modules returns the value of the pixel to be displayied
 * at coordinate (x, y) allowing to select when get as source
 * the text or the raster buffer.
 *
 * RASTER MODE
 * -----------
 *
 * We use a Dual RAM of 640x480*3 = 921600 bits = 115200 bytes; this
 * will contain the raw RGB values to display.
 *
 *
 * TEXT MODE
 * ---------
 *
 * We want to write some text using glyph stored into some ROM.
 *
 * Each glyph is a matrix of 8x16 pixels, we want to cover at least the
 * first 127 ASCII character, so we need at least 128*128 = 16384 bits
 * (so an address space of 14 bits).
 *
 * 640x480 will give us 80x30 characters, so the TEXT buffer needs 2400 bytes
 * (so an address space of 12 bits).
 *
 * NB: since there are two memories involved, there are two clock cycles
 *     of delay before the right pixel values come out.
 *
 */
module framebuffer(
	input wire clk,
	
	input wire [10:0] x,
	input wire [10:0] y,
	
	output wire [2:0] o_pixel
);

//parameter num_columns = 128;//1024 / 8
parameter num_columns = 80;//640 / 8

wire [7:0] column; //80 columns
wire [5:0] row; //30 rows
wire [12:0] text_address;//numéro de case du caractère sur l'écran
wire [7:0] text_value; // code ascii du caractère à afficher
//reg [7:0] text_value; // code ascii du caractère à afficher
reg [7:0] text_code; // code ascii du caractère à afficher

// coordonnées du caractère à dessiner
reg [2:0] glyph_x;
reg [3:0] glyph_y;
wire [13:0] glyph_address;

// (column,row) = (x / 8, y / 16)
assign column = x[10:3];
assign row = y[9:4];

/* text_address servira plus tard à récupérer le texte dans une RAM (futur projet) */
assign text_address = column + (row * num_columns);

always @ (text_address) begin
	case(column + (row * num_columns))
		12'd0: text_code <= 8'd72;
		//12'd0: text_code <= 8'd1;
		12'd1: text_code <= 8'd69;
		12'd2: text_code <= 8'd76;
		12'd3: text_code <= 8'd76;
		12'd4: text_code <= 8'd79;
		12'd5: text_code <= 8'd32;
		12'd6: text_code <= 8'd87;
		12'd7: text_code <= 8'd79;
		12'd8: text_code <= 8'd82;
		12'd9: text_code <= 8'd76;
		12'd10: text_code <= 8'd68;
		12'd11: text_code <= 8'd33;
		12'd80: text_code <= 8'd42;
		12'd81: text_code <= 8'd42;
		12'd82: text_code <= 8'd42;
		12'd83: text_code <= 8'd42;
		12'd84: text_code <= 8'd42;
		12'd85: text_code <= 8'd42;
		12'd86: text_code <= 8'd42;
		12'd87: text_code <= 8'd42;
		12'd88: text_code <= 8'd42;
		12'd89: text_code <= 8'd42;
		12'd90: text_code <= 8'd42;
		12'd91: text_code <= 8'd42;
		default: text_code <= 0;
	endcase
end

//always @(posedge clk) begin
always @(x,y) begin
	glyph_x <= x[2:0];
	glyph_y <= y[3:0];
end

assign text_value = text_code;

// text_value * (8 * 16) + glyph_x + glyph_y * 8
assign glyph_address = (text_value << 7) + glyph_x + (glyph_y << 3);

glyph_rom glyph(
	.address(glyph_address),
	.clock(clk),
	.q(o_pixel)
);


/* on affiche un texte blanc en sortie */
assign o_pixel[1] = o_pixel[0];
assign o_pixel[2] = o_pixel[0];
 
endmodule