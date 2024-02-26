function core_visuaizer(N, v)
    % v is a vector arranged such that its (\sum_{i \in S} 2^{i - 1})th
    % element is the worth of coalition S \ \forall S \ne \emptyset. for
    % example, the 6th element is the worth of \{2, 3\}.
    
    % the core consists of imputations x that satisfy
    % alpha(i) <= x(i) <= omega(i) \forall i.
    
    % normalization by v((2^N) - 1) is only for convenience.
    
    if length(v) ~= (2^N) - 1
        error('expected %i coalitions in v, not %i.', (2^N) - 1, length(v));
    end
    
    alpha(1) = v(1) / v((2^N) - 1);
    alpha(2) = v(2) / v((2^N) - 1);
    alpha(3) = v(4) / v((2^N) - 1);
    
    omega(1) = (v((2^N) - 1) - v((2^N) - 1 - (2^0))) / v((2^N) - 1);
    omega(2) = (v((2^N) - 1) - v((2^N) - 1 - (2^1))) / v((2^N) - 1);
    omega(3) = (v((2^N) - 1) - v((2^N) - 1 - (2^2))) / v((2^N) - 1);
    
    % equations for player 1
    
    y1     = @(x) sqrt(3) - (sqrt(3) * x);
    y1_max = @(x) y1(x + omega(1));
    y1_min = @(x) y1(x + alpha(1));
    
    % equations for player 2
    
    y2     = @(x) sqrt(3) * x;
    y2_max = @(x) y2(x - omega(2));
    y2_min = @(x) y2(x - alpha(2));
    
    % equations for player 3
    
    y3     = @(x) zeros(1, length(x));
    y3_max = @(x) y3(x) + (omega(3) * (0.5 * sqrt(3)));
    y3_min = @(x) y3(x) + (alpha(3) * (0.5 * sqrt(3)));
    
    % plot the core
    
    figure;
    hold on;
    
    verts = [0, 0; 0.5, sqrt(3) / 2; 1, 0];
    x     = [0, 1];
    
    fill(verts(:, 1), verts(:, 2), 'b');
    fill([x, fliplr(x)], [y1_min(x), fliplr(y1(x))], 'w', 'EdgeColor', 'none');
    fill([x, fliplr(x)], [y2_min(x), fliplr(y2(x))], 'w', 'EdgeColor', 'none');
    fill([x, fliplr(x)], [y3_min(x), fliplr(y3(x))], 'w', 'EdgeColor', 'none');
    fill([x, fliplr(x)], [y1_max(x), fliplr(y3_min(x))], 'w', 'EdgeColor', 'none');
    fill([x, fliplr(x)], [y2_max(x), fliplr(y3_min(x))], 'w', 'EdgeColor', 'none');
    fill([x, fliplr(x)], [y3_max(x), fliplr(y1(x))], 'w', 'EdgeColor', 'none');
    
    triplot(triangulation([1 2 3], verts));
    text(0, 0, ['(', num2str(v((2^N) - 1)), ', 0, 0)'], 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle');
    text(1, 0, ['(0, ', num2str(v((2^N) - 1)), ', 0)'], 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle');
    text(0.5, sqrt(3) / 2, ['(0, 0, ', num2str(v((2^N) - 1)), ')'], 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
    
    plot(x, y1_min(x));
    plot(x, y1_max(x));
    plot(x, y2_min(x));
    plot(x, y2_max(x));
    plot(x, y3_min(x));
    plot(x, y3_max(x));
    
    xlim([-0.2, 1.2]);
    ylim([-0.2, (sqrt(3) / 2) + 0.2]);
    set(gca, 'XColor', 'none', 'YColor', 'none');
    title('Core of the Game');
    hold off;

end