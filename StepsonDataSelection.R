Steps on Data Selection
#sum(dataset$TARGET_D>0)/nrow(dataset)
#donations = ( dataset$TARGET_D[dataset$TARGET_D>0])

get_frequency <- function(categorical_variable)
{
  freq = table(categorical_variable)/length(categorical_variable)
  return(freq)
}

feature_selection <- function(dataset, topK)
{
  #CATEGORICAL->NUMERICAL
  categorical_variables =c()
  entropy_values =c()
  
  names_variables = names(dataset) 
  for(i in 1:ncol(dataset))
  {
    name = names_variables[i]
    if(is.factor(dataset[[name]])==TRUE)
    {
      categorical_variables = c(categorical_variables, name)
      freq = get_frequency(dataset[[name]])
      dataset[[name]] = freq[dataset[[name]]]
    }
    
    print(c('variable: ', name))
    entropy_value = entropy.empirical(dataset[[name]])
    print(c('entropy_value: ', entropy_value))
    entropy_values = c(entropy_values, entropy_value)
  }
  
  #SORT ENTROPIES AND CHOOSE THOSE ONES WITH LOWES VALUES
  sorted = sort(entropy_values, index.return=TRUE)
  sorted_indices = sorted$ix[1:topK]
  
  dataset_featureselected = dataset[,sorted_indices]
  return (dataset_featureselected)
}

library('entropy')
dataset = read.csv('C:\\Users\\OmarYeva\\Desktop\\GGUFall2015\\DataAnalytics\\finalproject\\cup98LRN_1000rows_cleaned.csv')
final_dataset = feature_selection(dataset, 200)
> dim(final_dataset)
[1] 9999   30

#THE SET OF MORE VARIABLE FEATURES (IN INCREASING ORDER)
names_variables[sorted$ix]

