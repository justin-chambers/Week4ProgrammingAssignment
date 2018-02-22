library(data.table)
library(dplyr)

tr_subjects <- data.frame(fread("./data/train/subject_train.txt", header = FALSE))
ts_subjects <- data.frame(fread("./data/test/subject_test.txt", header = FALSE))
tr_features <- data.frame(fread("./data/train/X_train.txt", sep = " ", header = FALSE))
ts_features <- data.frame(fread("./data/test/X_test.txt", sep = " ", header = FALSE))
tr_labels <- data.frame(fread("./data/train/y_train.txt", header = FALSE))
ts_labels <- data.frame(fread("./data/test/y_test.txt", header = FALSE))
var_names <- fread("./data/features.txt", sep = " ", header = FALSE)
obs_desc <- fread("./data/activity_labels.txt", sep = " ", header = FALSE)
colnames(tr_features) <- var_names$V2
colnames(ts_features) <- var_names$V2
tr_labels <- sapply(tr_labels$V1, function(el) { tolower(obs_desc[ el, 2]) })
ts_labels <- sapply(ts_labels$V1, function(el) { tolower(obs_desc[ el, 2]) })
tr_features <- tr_features[ , grep("[Mm]ean\\(|[Ss]td\\(", colnames(tr_features))] %>% 
        mutate(activityType := tr_labels) %>%
        mutate(subjectNumber := as.integer(tr_subjects[, 1]))
ts_features <- ts_features[ , grep("[Mm]ean\\(|[Ss]td\\(", colnames(ts_features))] %>% 
        mutate(activityType := ts_labels)%>%
        mutate(subjectNumber := as.integer(ts_subjects[, 1]))
m <- merge(tr_features, ts_features, all = TRUE)
rm(ts_labels, ts_features, ts_subjects, tr_labels, tr_features, tr_subjects, var_names, obs_desc)
out <- m %>% group_by(subjectNumber, activityType) %>% summarise_all(funs(average = mean))
write.table(out, "./selected_feature_averages_by_subject_and_activity.txt", row.name = FALSE)
rm(m, out)
print("Analysis complete. Check current directory for output file.")
