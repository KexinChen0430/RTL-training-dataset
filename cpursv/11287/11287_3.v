
module fpga_eth_filter(input  wire clk,
                       input  wire reset_n,
                       input  wire rxd,
                       output wire txd,
                       output wire eth0_clk,
                       input  wire [7:0] eth0_rxd,
                       input  wire eth0_rxdv,
                       input  wire eth0_rxer,
                       output wire [7:0] eth0_txd,
                       output wire eth0_txen,
                       output wire eth1_clk,
                       input  wire [7:0] eth1_rxd,
                       input  wire eth1_rxdv,
                       input  wire eth1_rxer,
                       output wire [7:0] eth1_txd,
                       output wire eth1_txen,
                       output wire [7:0] debug);

  reg  [63:0] udp_ctr_reg;
  reg  [63:0] udp_ctr_new;
  reg  udp_ctr_inc;
  reg  udp_ctr_we;
  reg  [63:0] tcp_ctr_reg;
  reg  [63:0] tcp_ctr_new;
  reg  tcp_ctr_inc;
  reg  tcp_ctr_we;
  reg  [63:0] icmp_ctr_reg;
  reg  [63:0] icmp_ctr_new;
  reg  icmp_ctr_inc;
  reg  icmp_ctr_we;
  reg  [63:0] ipv4_ctr_reg;
  reg  [63:0] ipv4_ctr_new;
  reg  ipv4_ctr_inc;
  reg  ipv4_ctr_we;
  reg  [63:0] ipv6_ctr_reg;
  reg  [63:0] ipv6_ctr_new;
  reg  ipv6_ctr_inc;
  reg  ipv6_ctr_we;

  assign txd = 1'b0;
  assign debug = 8'h00;
  assign eth0_txd = eth1_rxd;
  assign eth0_txen = eth1_rxdv;
  assign eth1_txd = eth0_rxd;
  assign eth1_txen = eth0_rxdv;
  assign eth0_clk = clk;
  assign eth1_clk = clk;
  
  always @(posedge clk or negedge reset_n)
      begin : reg_update
        if (!reset_n) 
          begin
            udp_ctr_reg <= 64'h0000000000000000;
            tcp_ctr_reg <= 64'h0000000000000000;
            icmp_ctr_reg <= 64'h0000000000000000;
            ipv4_ctr_reg <= 64'h0000000000000000;
            ipv6_ctr_reg <= 64'h0000000000000000;
          end
        else 
          begin
            if (udp_ctr_we) 
              begin
                udp_ctr_reg <= udp_ctr_new;
              end
              
            if (tcp_ctr_we) 
              begin
                tcp_ctr_reg <= tcp_ctr_new;
              end
              
            if (icmp_ctr_we) 
              begin
                icmp_ctr_reg <= icmp_ctr_new;
              end
              
            if (ipv4_ctr_we) 
              begin
                ipv4_ctr_reg <= ipv4_ctr_new;
              end
              
            if (ipv6_ctr_we) 
              begin
                ipv6_ctr_reg <= ipv6_ctr_new;
              end
              
          end
      end
  
  always @* 
      begin : udp_ctr
        udp_ctr_new = udp_ctr_reg;
        udp_ctr_we = 0;
        if (udp_ctr_inc) 
          begin
            udp_ctr_new = 1'b1+udp_ctr_reg;
            udp_ctr_we = 1;
          end
          
      end
  
  always @* 
      begin : tcp_ctr
        tcp_ctr_new = tcp_ctr_reg;
        tcp_ctr_we = 0;
        if (tcp_ctr_inc) 
          begin
            tcp_ctr_new = tcp_ctr_reg+1'b1;
            tcp_ctr_we = 1;
          end
          
      end
  
  always @* 
      begin : icmp_ctr
        icmp_ctr_new = icmp_ctr_reg;
        icmp_ctr_we = 0;
        if (icmp_ctr_inc) 
          begin
            icmp_ctr_new = 1'b1+icmp_ctr_reg;
            icmp_ctr_we = 1;
          end
          
      end
  
  always @* 
      begin : ipv4_ctr
        ipv4_ctr_new = ipv4_ctr_reg;
        ipv4_ctr_we = 0;
        if (ipv4_ctr_inc) 
          begin
            ipv4_ctr_new = 1'b1+ipv4_ctr_reg;
            ipv4_ctr_we = 1;
          end
          
      end
  
  always @* 
      begin : ipv6_ctr
        ipv6_ctr_new = ipv6_ctr_reg;
        ipv6_ctr_we = 0;
        if (ipv6_ctr_inc) 
          begin
            ipv6_ctr_new = ipv6_ctr_reg+1'b1;
            ipv6_ctr_we = 1;
          end
          
      end
  
  always @* 
      begin : eth_parser
        udp_ctr_inc = 0;
        tcp_ctr_inc = 0;
        icmp_ctr_inc = 0;
        ipv4_ctr_inc = 0;
        ipv6_ctr_inc = 0;
      end
endmodule

