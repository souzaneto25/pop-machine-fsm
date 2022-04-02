LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY pop_machine_fsm IS
    PORT (
        --clock e reset de entradas
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        --sensor da moeda
        c : IN STD_LOGIC;
        --preço do refrigerante
        s : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        --preço da moeda
        a : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        --saida da maquina
        d : OUT STD_LOGIC;
        --troco da maquina
        troco : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)

    );
END ENTITY pop_machine_fsm;

ARCHITECTURE arch OF pop_machine_fsm IS
    --declarando o bloco de controle
    COMPONENT control IS
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            c : IN STD_LOGIC;
            tot_lt_s : IN STD_LOGIC;
            tot_eq_s : IN STD_LOGIC;
            tot_hg_s : IN STD_LOGIC;
            d : OUT STD_LOGIC;
            tot_ld : OUT STD_LOGIC;
            tot_clr : OUT STD_LOGIC
        );
    END COMPONENT control;

    --declarando o bloco operacional
    COMPONENT datapath IS
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            tot_ld : IN STD_LOGIC;
            tot_clr : IN STD_LOGIC;
            s : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            a : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	    troco : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            tot_lt_s : OUT STD_LOGIC;
            tot_eq_s : OUT STD_LOGIC;
            tot_hg_s : OUT STD_LOGIC
        );
    END COMPONENT datapath;

    --declarando os sinais entre eles
    SIGNAL tot_ld : STD_LOGIC;
    SIGNAL tot_clr : STD_LOGIC;
    SIGNAL tot_lt_s : STD_LOGIC;
    SIGNAL tot_eq_s : STD_LOGIC;
    SIGNAL tot_hg_s : STD_LOGIC;
BEGIN
--conectando os sinais aos do bloco de controle
machine_control: control port map(
    clk      => clk,
    rst      => rst,
    tot_clr  => tot_clr,
    tot_lt_s => tot_lt_s,
    tot_eq_s => tot_eq_s,
    tot_hg_s => tot_hg_s,
    tot_ld   => tot_ld,
    c        => c,
    d        => d
);
--conectando os sinais aos do bloco operacional
machine_datapath: datapath port map(
    clk      => clk,
    rst      => rst,
    tot_clr  => tot_clr,
    tot_ld   => tot_ld,
    tot_lt_s => tot_lt_s,
    tot_eq_s => tot_eq_s,
    tot_hg_s => tot_hg_s,
    troco    => troco,
    a        => a,
    s        => s
);

END ARCHITECTURE arch;
