## run_analysis.R
#### This script reads and cleans the data provided in the week 4 project assignment.
#### Once the data has been read and cleaned, the data are merged, grouped, and summarized
#### per the assignment instructions. The resulting tidy data table is written out as a
#### text file in the script's parent directory.

## libraries
library(data.table)
library(dplyr)

## functions

### initDataFrame
#### @brief  function takes a directory path, fast reads the file contents and returns a data.frame
#### @args   file_path - the string representing the directory path
#### @return df - the data.frame containing the file content
initDataFrame <- function(file_path) {
        df <- fread(file_path, sep = " ", header = FALSE, data.table = FALSE, stringsAsFactors = FALSE)
}

### tidyChain
#### @brief  function takes 3 data.frames (features, labels, and subjects) and combines them into
####         a single data.frame with the necessary subsetting and mutating the project requires
#### @args   df - data.frame representing the features
####         lbls - data.frame representing the labels
####         subjs - data.frame representing the subjects
#### @return df - tidied data.frame
tidyChain <- function(df, lbls, subjs) {
        df <- df[ , grep("[Mm]ean\\(|[Ss]td\\(", colnames(df))] %>% 
                mutate(activityType := lbls) %>%
                mutate(subjectNumber := as.integer(subjs[, 1]))       
}

## main script

### initialize data.frames
tr_subjects <- initDataFrame("./data/train/subject_train.txt")
ts_subjects <- initDataFrame("./data/test/subject_test.txt")
tr_features <- initDataFrame("./data/train/X_train.txt")
ts_features <- initDataFrame("./data/test/X_test.txt")
tr_labels <- initDataFrame("./data/train/y_train.txt")
ts_labels <- initDataFrame("./data/test/y_test.txt")
var_names <- initDataFrame("./data/features.txt")
obs_desc <- initDataFrame("./data/activity_labels.txt")

### add column names to feature data.frames (required for "tidy data")
colnames(tr_features) <- var_names$V2
colnames(ts_features) <- var_names$V2

### reinterpret the activity descriptions and match them to the proper activity labels
tr_labels <- sapply(tr_labels$V1, function(el) { tolower(obs_desc[ el, 2]) })
ts_labels <- sapply(ts_labels$V1, function(el) { tolower(obs_desc[ el, 2]) })

### tidy up the data.frames before merging...
tr_features <- tidyChain(tr_features, tr_labels, tr_subjects)
ts_features <- tidyChain(ts_features, ts_labels, ts_subjects)

### merge data.frames
m <- merge(tr_features, ts_features, all = TRUE)

### generate the tidy data - grouped by subject and activity, averaging all other features
out <- m %>% group_by(subjectNumber, activityType) %>% 
        summarise_all(funs(average = mean))

### since the raw numbers were provided in scientific notation, format the derived summary data so
### that the output format matches the input format
out <- format.data.frame(out, scientific = TRUE)

### write the output to text
write.table(out, "./selected_feature_averages_by_subject_and_activity.txt", row.name = FALSE)

### clean up functions and variables used
rm(initDataFrame, tidyChain)
rm(ts_labels, ts_features, ts_subjects, tr_labels, tr_features, tr_subjects, var_names, obs_desc)
rm(m, out)

### alert user that script has finished
print("Analysis complete. Check current directory for output file.")
