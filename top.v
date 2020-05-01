module  top #(
    parameter  reserved   = 'd0
)
(
	inout  clk_in,
    output reg [35:0] pixdata,
    output reg fv,
    output reg lv,
    output pixclk,
	output reg de,
	
	// HDMI configuration
	inout 			HDMI_scl,
	inout 			HDMI_sda,

	output test
);


reg reset_n;
wire clk24M;
wire de;

/*
OSCH #(
    .NOM_FREQ("24.18")
)u_OSCH
(
    .STDBY(0),
    .OSC(clk24M)
);
*/

always @ (posedge clk24M)
begin
	if (!reset_n ) reset_n <= 1;
end

wire w_pixclk;
//pll_sensor_clk u_pll_sensor_clk(.CLKI(clk_in), .CLKOP(w_pixclk), .CLKOS(pixclk));

pll_sensor_clk u_pll_sensor_clk(.CLKI(clk24M), .CLKOP(w_pixclk));
assign pixclk = ~w_pixclk;

wire w_fv;
wire w_lv;
wire [35:0] w_pixdata;


always @ (posedge w_pixclk or negedge reset_n)
begin
	if(!reset_n) begin
		pixdata <= 0;
		fv <= 0;
		lv <= 0;
	end
	else begin
		pixdata <= w_pixdata;
		fv <= w_fv;
		lv <= w_lv;
	end
end

colorbar_gen #(
	.h_active('d1920),
    .h_total('d2200),
    .v_active('d1080),
    .v_total('d1125),
    .H_FRONT_PORCH('d88),    
    .H_SYNCH('d44), 
    .H_BACK_PORCH('d148),
    .V_FRONT_PORCH('d4),
    .V_SYNCH('d5)
)u_colorbar_gen
(
	.rstn       (reset_n  ) , 
	.clk        (w_pixclk) ,
	.fv         () ,
	.lv         () ,
	.data       (w_pixdata),
	.de         (de),
	.vsync      (w_fv),
	.hsync      (w_lv)
);

hdmi_i2c_top hdmi_i2c_top_inst(
	.rst_n			(reset_n),
	.clk			(clk_in),
	.scl			(HDMI_scl),
	.sda			(HDMI_sda),
	.config_done 	()
);

endmodule
