module a( 
    parameter AUM=80; 
    parameter BUM=70; 
    parameter VUM=1;  
    parameter V2=2;   
    input my_data_z; 
    input my_data_v[VUM]; 
    input my_data_vv[VUM][V2]; 
    input [AUM-1:0] my_data_av[VUM]; 
    input [AUM-1:0][BUM-1:0] my_data_ab; 
    input [AUM-1:0][BUM-1:0] my_data_abv[VUM]; 
    input [XUM-1:0][YUM-1:0] my_data_xyz[ZUM]; 
    input PARAMS0__t params0 [1:0]; 
    input PARAMS1__t params1 [1:0]; 
); 
endmodule 