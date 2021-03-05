# utl-Convert-all-character-variables-to-numeric-and-use-the-same-variable-names
Convert all character variables to numeric and use the same variable names
    Convert all character variables to numeric and use the same variable names

    Github
    https://tinyurl.com/sdw2eczx
    https://github.com/rogerjdeangelis/utl-Convert-all-character-variables-to-numeric-and-use-the-same-variable-names

    SAS Forum
    https://tinyurl.com/3wsb33ke
    https://communities.sas.com/t5/SAS-Programming/Convert-all-character-variables-to-numeric-and-use-the-same/m-p/720186

    TOOLS
    https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories

    *_                   _
    (_)_ __  _ __  _   _| |_
    | | '_ \| '_ \| | | | __|
    | | | | | |_) | |_| | |_
    |_|_| |_| .__/ \__,_|\__|
            |_|
    ;

    data have; /* Example of actual data set */
        input (a b c d e) ($);
        cards4;
    1 1 1 1 1
    ;;;;
    run;quit;


     Variables in Creation Order

    #    Variable    Type    Len

    1    A           Char      8
    2    B           Char      8
    3    C           Char      8
    4    D           Char      8
    5    E           Char      8

    *
     _ __  _ __ ___   ___ ___  ___ ___
    | '_ \| '__/ _ \ / __/ _ \/ __/ __|
    | |_) | | | (_) | (_|  __/\__ \__ \
    | .__/|_|  \___/ \___\___||___/___/
    |_|
    ;

    %array(chrs,values=%varlist(have));

    proc sql;
      create
        table want as
      select
        %do_over(chrs,phrase=%str(
           input(?,best.) as ?) ,between=comma)
      from
        have
    ;quit;

    *            _               _
      ___  _   _| |_ _ __  _   _| |_
     / _ \| | | | __| '_ \| | | | __|
    | (_) | |_| | |_| |_) | |_| | |_
     \___/ \__,_|\__| .__/ \__,_|\__|
                    |_|
    ;

     Variables in Creation Order

    #    Variable    Type    Len

    1    A           Num       8
    2    B           Num       8
    3    C           Num       8
    4    D           Num       8
    5    E           Num       8

