%% Sampling for the next generation of room structures(before variation),return the index of the children
% from the last generation

function children_numbers = sample_children_numbers(parent_fitness,N_children)

N_parents = length(parent_fitness);

%% Calculate cumulative distribution
likelihood = parent_fitness/sum(parent_fitness);
p = zeros(1,N_parents);
pk_last = 0;
for k=1:N_parents
    p(k) = pk_last + likelihood(k);
    pk_last = p(k);
end

%% Generate Children
children_numbers = zeros(1,N_children);
U = sort(rand(1,N_children));
k = 1;
thresh = p(1);
for sample=1:N_children
    if U(sample) < thresh
        % Span particle
    else
        while U(sample) > thresh
            thresh = p(k+1);
            k = k+1;
        end
        % Span particle
    end
    children_numbers(sample) = k;
end

