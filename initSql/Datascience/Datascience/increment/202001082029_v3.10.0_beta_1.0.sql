update science_task_template
set content = 'from sklearn import datasets, svm, metrics

# The digits dataset
digits = datasets.load_digits()
print(digits.target)
import numpy as np


n_samples = len(digits.images)
data = digits.images.reshape((n_samples, -1))
print(data[0])
print(digits.images[0])
print(n_samples)
# Create a classifier: a support vector classifier
classifier = svm.LinearSVC(C=0.001)

# We learn the digits on the first half of the digits
classifier.fit(data[:n_samples // 2], digits.target[:n_samples // 2])

# Now predict the value of the digit on the second half:
expected = digits.target[n_samples // 2:]
predicted = classifier.predict(data[n_samples // 2:])

print("Classification report for classifier %s:%s"% (classifier, metrics.classification_report(expected, predicted)))
print("Confusion matrix:%s" % metrics.confusion_matrix(expected, predicted))'
where type = 3;

update science_task
set sql_text = 'from sklearn import datasets, svm, metrics

# The digits dataset
digits = datasets.load_digits()
print(digits.target)
import numpy as np


n_samples = len(digits.images)
data = digits.images.reshape((n_samples, -1))
print(data[0])
print(digits.images[0])
print(n_samples)
# Create a classifier: a support vector classifier
classifier = svm.LinearSVC(C=0.001)

# We learn the digits on the first half of the digits
classifier.fit(data[:n_samples // 2], digits.target[:n_samples // 2])

# Now predict the value of the digit on the second half:
expected = digits.target[n_samples // 2:]
predicted = classifier.predict(data[n_samples // 2:])

print("Classification report for classifier %s:%s"% (classifier, metrics.classification_report(expected, predicted)))
print("Confusion matrix:%s" % metrics.confusion_matrix(expected, predicted))'
where name = 'SVM';