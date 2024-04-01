:- module(top).
:-export(top/0).

:-lib(ic).
:-use_module("../visualization").
:-use_module("../label").

top:-
        sendmory(L1,"TREE",yes),
        writeln(L1),
        sendmory(L2,"FULL",no),
        writeln(L2),
        sendmory_wrong("WRONG",no),
        writeln(L2),
        sendmory_split(K,"SPLIT",no),
        writeln(K).

sendmory(L,Output,IgnoreFixed):-
	L=[S,E,N,D,M,O,R,Y],
	L :: 0..9,
        create_visualization([format:svg,
                              root:frame,
                              output:Output,
                              width:8,
                              height:10,
                              inc:12],Handle),
        add_visualizer(Handle,
                       vector(L),
                       [display:expanded,
                        y:0]),
        
	alldifferent(L),
        draw_visualization(Handle),
	S #\= 0,
        draw_visualization(Handle),
	M #\= 0,
        draw_visualization(Handle),
	
	1000*S+100*E+10*N+D + 
	1000*M+100*O+10*R+E #= 
	10000*M + 1000*O+100*N+10*E+Y,
        draw_visualization(Handle),

        named(L,['S','E','N','D','M','O','R','Y'],Pairs),
        concat_string([Output,"/","tree.tre"],TreeFile),
        create_search_tree(TreeFile,TreeHandle,[vis_handle:Handle,
                                                ignore_fixed:IgnoreFixed,
                                                name_arg:2,
                                                focus_arg:3]),
        findall(x,label(Pairs,1,input_order,indomain,TreeHandle),_),
        close_search_tree(TreeHandle),
        close_visualization(Handle).

sendmory_wrong(Output,IgnoreFixed):-
	L=[S,E,N,D,M,O,R,Y],
	L :: 0..9,
        create_visualization([format:svg,
                              root:frame,
                              output:Output,
                              width:8,
                              height:10,
                              inc:12],Handle),
        add_visualizer(Handle,
                       vector(L),
                       [display:expanded,
                        y:0]),
        
	alldifferent(L),
        draw_visualization(Handle),
	
	1000*S+100*E+10*N+D + 
	1000*M+100*O+10*R+E #= 
	10000*M + 1000*O+100*N+10*E+Y,
        draw_visualization(Handle),

        named(L,['S','E','N','D','M','O','R','Y'],Pairs),
        concat_string([Output,"/","tree.tre"],TreeFile),
        create_search_tree(TreeFile,TreeHandle,[vis_handle:Handle,
                                                ignore_fixed:IgnoreFixed,
                                                name_arg:2,
                                                focus_arg:3]),
        findall(x,label(Pairs,1,input_order,indomain,TreeHandle),_),
        close_search_tree(TreeHandle),
        close_visualization(Handle).

sendmory_split(L,Output,IgnoreFixed):-
	L=[S,E,N,D,M,O,R,Y],
	L :: 0..9,
        create_visualization([format:svg,
                              root:frame,
                              output:Output,
                              width:8,
                              height:10,
                              inc:12],Handle),
        add_visualizer(Handle,
                       vector(L),
                       [display:expanded,
                        y:0]),
        
        [C2,C3,C4,C5] :: 0..1,
	alldifferent(L),
        draw_visualization(Handle),
	S #\= 0,
        draw_visualization(Handle),
	M #\= 0,
        draw_visualization(Handle),
	

        M #= C5,
        draw_visualization(Handle),
        S+M+C4 #= 10*C5+O,
        draw_visualization(Handle),
        E+O+C3 #= 10*C4+N,
        draw_visualization(Handle),
        N+R+C2 #= 10*C3+E,
        draw_visualization(Handle),
        D+E    #= 10*C2+Y,
        draw_visualization(Handle),

        named(L,['S','E','N','D','M','O','R','Y'],Pairs),
        concat_string([Output,"/","tree.tre"],TreeFile),
        create_search_tree(TreeFile,TreeHandle,[vis_handle:Handle,
                                                ignore_fixed:IgnoreFixed,
                                                name_arg:2,
                                                focus_arg:3]),
        findall(x,label(Pairs,1,input_order,indomain,TreeHandle),_),
        close_search_tree(TreeHandle),
        close_visualization(Handle).

