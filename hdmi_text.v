module hdmi_text(
	//** input **
	input wire clock50, 
	input wire rst_n,
	
	// ********************************************** //
	// ** HDMI CONNECTIONS **
	
	// AUDIO
	// SPDIF déconnecté
	output HDMI_I2S0, // non utilisé
	output HDMI_MCLK, // non utilisé
	output HDMI_LRCLK, // non utilisé
	output HDMI_SCLK, // non utilisé
	
	// VIDEO
	output [23:0] HDMI_TX_D, // RGBchannel
	output HDMI_TX_VS, // vsync
	output HDMI_TX_HS, // hsync
	output HDMI_TX_DE, // dataEnable
	output HDMI_TX_CLK, // vgaClock
	
	// REGISTERS AND CONFIG LOGIC
	// HPD vient du connecteur
	input HDMI_TX_INT,
	inout HDMI_I2C_SDA, 	// HDMI i2c data
	output HDMI_I2C_SCL, // HDMI i2c clock
	//output READY 			// HDMI is ready signal from i2c module
	output [7:0] led	// HDMI is ready signal from i2c module
	// ********************************************** //
	);

wire clockHDMI,locked;
wire rst = ~rst;

// signaux audio à haute impédence
assign HDMI_I2S0 = 1'b z;
assign HDMI_MCLK = 1'b z;
assign HDMI_LRCLK = 1'b z;
assign HDMI_SCLK = 1'b z;

// ** VGA CLOCK **
pll_hdmi pll_hdmi(
	.refclk(clock50),
	.rst(rst),
	
	.outclk_0(clockHDMI),
	.locked(locked)
);

// ** VGA MAIN CONTROLLER **
vgaHdmi vgaHdmi (
	// input
	.clock	(clockHDMI),
	.clock50	(clock50),
	.reset	(~locked),
	
	// ouput
	.hsync	(HDMI_TX_HS),
	.vsync	(HDMI_TX_VS),
	.dataEnable	(HDMI_TX_DE),
	.vgaClock	(HDMI_TX_CLK),
	.RGBchannel	(HDMI_TX_D)
);

// ** I2C Interface for ADV7513 initial config **
I2C_HDMI_Config I2C_HDMI_Config(
	.iCLK				(clock50),
	.iRST_N			(rst_n),
	.I2C_SCLK		(HDMI_I2C_SCL),
	.I2C_SDAT		(HDMI_I2C_SDA),
	.HDMI_TX_INT	(HDMI_TX_INT),
	.READY			(led[7:4])
);

endmodule