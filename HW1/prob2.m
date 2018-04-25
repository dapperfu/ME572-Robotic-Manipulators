mov = avifile('fourbar.avi','FPS',45);
link=link_solver(4,90,2,-180,0.5,0:360,[],[]);
for i=1:length(link)
    draw_bar(link(i),'off');
    axis([-6.5 6.5 -6.5 6.5])
    F = getframe(gca);
    mov = addframe(mov,F);
end
mov = close(mov);