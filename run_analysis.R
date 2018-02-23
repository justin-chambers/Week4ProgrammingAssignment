library(data.table)
library(dplyr)

initDataFrame <- function(file_path) {
        df <- fread(file_path, sep = " ", header = FALSE, data.table = FALSE, stringsAsFactors = FALSE)
}

tr_subjects <- initDataFrame("./data/train/subject_train.txt")
ts_subjects <- initDataFrame("./data/test/subject_test.txt")
tr_features <- initDataFrame("./data/train/X_train.txt")
ts_features <- initDataFrame("./data/test/X_test.txt")
tr_labels <- initDataFrame("./data/train/y_train.txt")
ts_labels <- initDataFrame("./data/test/y_test.txt")
var_names <- initDataFrame("./data/features.txt")
obs_desc <- initDataFrame("./data/activity_labels.txt")
colnames(tr_features) <- var_names$V2
colnames(ts_features) <- var_names$V2
tr_labels <- sapply(tr_labels$V1, function(el) { tolower(obs_desc[ el, 2]) })
ts_labels <- sapply(ts_labels$V1, function(el) { tolower(obs_desc[ el, 2]) })
tr_features <- tr_features[ , grep("[Mm]ean\\(|[Ss]td\\(", colnames(tr_features))] %>% 
        mutate(activityType := tr_labels) %>%
        mutate(subjectNumber := as.integer(tr_subjects[, 1]))
ts_features <- ts_features[ , grep("[Mm]ean\\(|[Ss]td\\(", colnames(ts_features))] %>% 
        mutate(activityType := ts_labels) %>%
        mutate(subjectNumber := as.integer(ts_subjects[, 1]))
m <- merge(tr_features, ts_features, all = TRUE)
rm(ts_labels, ts_features, ts_subjects, tr_labels, tr_features, tr_subjects, var_names, obs_desc)
out <- m %>% group_by(subjectNumber, activityType) %>% 
        summarise_all(funs(average = mean))
out <- format.data.frame(out, scientific = TRUE)
write.table(out, "./selected_feature_averages_by_subject_and_activity.txt", row.name = FALSE)
rm(m, out)
print("Analysis complete. Check current directory for output file.")
