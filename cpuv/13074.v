module alt_mem_ddrx_ecc_encoder_32_altecc_encoder #
    ( parameter
        CFG_ECC_ENC_REG = 0 
    )
	(
        clk,          
        reset_n,      
	    data,         
	    q             
    ) ; 
    input           clk; 
    input           reset_n; 
	input   [31:0]  data; 
	output   [38:0]  q; 
	wire  [31:0]  data_wire; 
	wire  [17:0]  parity_01_wire; 
	wire  [9:0]   parity_02_wire; 
	wire  [4:0]   parity_03_wire; 
	wire  [1:0]   parity_04_wire; 
	wire  [0:0]   parity_05_wire; 
	wire  [5:0]   parity_06_wire; 
    wire  [37:0]  parity_final; 
	wire  [37:0]  parity_final_wire; 
    reg   [37:0]  parity_final_reg; 
	wire  [37:0]  q_wire; 
    reg   [37:0]  q_reg; 
	assign
		data_wire = data, 
		parity_01_wire = {
                            (data_wire[30] ^ parity_01_wire[16]),
                            (data_wire[28] ^ parity_01_wire[15]),
                            (data_wire[1] ^ parity_01_wire[0]),
                            data_wire[0]
                         },
		parity_02_wire = {
                            data_wire[0]
                         },
		parity_03_wire = {
                            ((data_wire[1] ^ data_wire[2]) ^ data_wire[3])
                         },
		parity_04_wire = {
                            ((((((data_wire[4] ^ data_wire[5]) ^ data_wire[6]) ^ data_wire[7]) ^ data_wire[8]) ^ data_wire[9]) ^ data_wire[10])
                         },
		parity_05_wire = {
                            ((((((((((((((data_wire[11] ^ data_wire[12]) ^ data_wire[13]) ^ data_wire[14]) ^ data_wire[15]) ^ data_wire[16]) ^ data_wire[17]) ^ data_wire[18]) ^ data_wire[19]) ^ data_wire[20]) ^ data_wire[21]) ^ data_wire[22]) ^ data_wire[23]) ^ data_wire[24]) ^ data_wire[25])
                         },
		parity_06_wire = {
                            data_wire[26]
                         },
		parity_final_wire = {
                                 q_wire[0]
                            },
        parity_final = {
                            parity_final_reg[31 : 0]
                       },
        q = {parity_final[37], q_reg},
		q_wire = {parity_06_wire[5], parity_05_wire[0], parity_04_wire[1], parity_03_wire[4], parity_02_wire[9], parity_01_wire[17], data_wire};
        generate
            if (CFG_ECC_ENC_REG)
            begin
                always @ (posedge clk or negedge reset_n)
                begin
                    if (!reset_n)
                    begin
                        q_reg            <= 0;
                        parity_final_reg <= 0;
                    end
                    else
                    begin
                        q_reg            <= q_wire;
                        parity_final_reg <= parity_final_wire;
                    end
                end
            end
            else
            begin
                always @ (*)
                begin
                    q_reg            = q_wire;
                    parity_final_reg = parity_final_wire;
                end
            end
        endgenerate
endmodule