module test();
    reg clk_o; 
    reg rst_o; 
    reg [7:0] scenario_o; 
    reg [1:0] mode_o; 
    reg [7:0] d_o; 
    reg stb_o; 
    wire [7:0] q_i; 
    GPIA_BYTE dut (
        .clk_i(clk_o), 
        .res_i(rst_o), 
        .mode_i(mode_o), 
        .d_i(d_o), 
        .stb_i(stb_o), 
        .q_o(q_i) 
    );
    always begin
        #20 clk_o <= ~clk_o; 
    end
    task waitclk;
    begin @(negedge clk_o); @(posedge clk_o); 
    end
    endtask
    task setq;
    begin
        rst_o <= 0; 
        mode_o <= 0; 
        d_o <= 8'hFF; 
        stb_o <= 1; 
        waitclk; 
    end
    endtask
    initial begin
        clk_o <= 0; 
        rst_o <= 0; 
        scenario_o <= 8'h00; 
        mode_o <= 0; 
        d_o <= 0; 
        stb_o <= 0; 
        $dumpfile("test.vcd"); 
        $dumpvars; 
        @(posedge clk_o); 
        scenario_o <= 8'h01; 
        rst_o <= 1; 
        waitclk; 
        rst_o <= 0; 
        waitclk; 
        if(q_i == 1) begin 
            $display("FAIL 01: Q not $00"); $finish; 
        end
        $display("PASS"); $finish; 
    end
endmodule