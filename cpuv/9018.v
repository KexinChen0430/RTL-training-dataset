module test_engine_dummy #(parameter Thold = 5)
(
    input wire clk, 
    input wire start_strobe_din, 
    input wire [(2 * `CHANNEL_WIDTH)-1:0] wordA_din, 
    input wire [(2 * `CHANNEL_WIDTH)-1:0] wordB_din, 
    output reg done_strobe_dout, 
    output reg active_test_engine_dout, 
    output reg [(2 * `CHANNEL_WIDTH)-1:0] wordC_dout, 
    output reg [(2 * `CHANNEL_WIDTH)-1:0] wordD_dout 
);
reg [63:0] wordC;
reg [63:0] wordD;
integer packet_counter = 0;
event valid_data;
initial
    begin
        done_strobe_dout = 0;
        active_test_engine_dout = 0;
        wordC_dout = 0;
        wordD_dout = 0;
    end
always
    @(posedge start_strobe_din)
        begin
            @(posedge clk); 
            #(Thold); 
            wordC <= wordB_din; 
            wordD <= wordA_din; 
            active_test_engine_dout <= 1; 
            repeat(16) 
                @(posedge clk); 
            #(Thold); 
            -> valid_data; 
        end
always
    begin
        @(valid_data); 
            active_test_engine_dout <= 0; 
            done_strobe_dout <= 1; 
            wordC_dout <= wordC; 
            wordD_dout <= wordD; 
            @(posedge clk); 
                #(Thold); 
            done_strobe_dout <= 0; 
            wordC_dout <= {64{1'bx}}; 
            wordD_dout <= {64{1'bx}}; 
            packet_counter = packet_counter + 1; 
    end
endmodule 