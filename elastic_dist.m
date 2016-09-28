function [y, displ] = elastic_dist(x, h, w, alpha, sigma, filter_size)
    % output image
    y = zeros(h*w,1);
    
    n = h*w;
    % displacement field
    displ = zeros(n, 2);
    tmp_displ = zeros(n, 2);

    % initalize displacement field with uniform random values
    for i = 1:n
        tmp_displ(i,:) = [2*rand(1)-1 2*rand(1)-1];
    end
    
    % convolute the displacement field by Gaussian kernel
    for i = 0:(h-1)
        for j = 0:(w-1)
            sum = zeros(1,2);
            for k = 0:(filter_size-1)
                for l = 0:(filter_size-1)
                    if( i+k < 0 || i+k >= h || j+l < 0 || j+l >= w )
                        continue;
                    end

                    nd = ND(k-filter_size/2, l-filter_size/2, sigma);
                    sum(1) = sum(1) + tmp_displ((i+k)*w+(j+l)+1, 1) * nd;
                    sum(2) = sum(2) + tmp_displ((i+k)*w+(j+l)+1, 2) * nd;
                end
            end
            % multiply scalling factor alpha described by pepar
            displ(i*h+j+1,:) = alpha * sum;
        end
    end

    for i = 0:(h-1)
        for j = 0:(w-1)
            dx = displ(i*h+j+1,2); dy = displ(i*h+j+1,1);

            c = zeros(4,2);
            % check bounday condtions
            for k = 0:1
                for l = 0:1
                    tmp_x = floor(j + dx + l); tmp_y = floor(i + dy + k);
                    tmp_x = max(tmp_x, 0); tmp_x = min(tmp_x, w-1);
                    tmp_y = max(tmp_y, 0); tmp_y = min(tmp_y, h-1);

                    c(k*2+l+1,:) = [tmp_x tmp_y];
                end
            end

            % calculate linear interpolation
            dx = abs(j + dx - c(1,1)); dy = abs(i + dy - c(1,2));
            val1 = (x(c(2,2)*h+c(2,1)+1) - x(c(1,2)*h+c(1,1)+1))*dx + x(c(1,2)*h+c(1,1)+1);
            val2 = (x(c(4,2)*h+c(4,1)+1) - x(c(3,2)*h+c(3,1)+1))*dx + x(c(3,2)*h+c(3,1)+1);
            val = (val2 - val1)*dy + val1;

            y(i*h+j+1) = val;
        end
    end
end

function x = ND(x, y, sigma)
    x = 1.0 / sqrt(2*pi*sigma^2) * exp(-(x^2+y^2)/(2*sigma^2));
end
