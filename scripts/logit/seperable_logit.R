# Basic inference.
library('rjags')

df <- read.csv(file.path('data',
                         'logit',
                         'separable_logit.csv'))

with(df, plot(X, Y))

jags <- jags.model(file.path('bugs',
                             'logit',
                             'separable_logit.bugs'),
                   data = list('x' = with(df, X),
                               'y' = with(df, Y),
                               'N' = nrow(df)),
                   n.chains = 4,
                   n.adapt = 1000)
 
mcmc.samples <- coda.samples(jags,
                        c('a', 'b'),
                        5000)

plot(mcmc.samples)

summary(mcmc.samples)$statistics

# Compare with GLM solution.
glm(Y ~ X,
    data = df,
    family = binomial(link = 'logit'))
