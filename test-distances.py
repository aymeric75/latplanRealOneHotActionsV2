import tensorflow as tf

# Assume you have the following two vectors:
# The continuous vector of predictions
predictions = tf.constant([
    [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0],
    #[0.0, 1.0, 0.0]
    ]) # (2, 3) # <batch_size, vector's size>

# The ground truth one-hot vector
ground_truth = tf.constant([
    [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
    #[0.0, 0.0, 1.0]
]) # (2, 3) # <batch_size, vector's size>


#cross_entropy = tf.nn.softmax_cross_entropy_with_logits_v2(labels=ground_truth, logits=predictions)


#cosine_distance = tf.losses.cosine_distance(predictions, ground_truth, axis=0)

#loss = tf.keras.losses.categorical_crossentropy(predictions, ground_truth)

# 1)
# elementwise multiply PUIS la sum   =    <batch_size> of COSINE SIM !!!!
cosine_sims = tf.reduce_sum(tf.math.multiply(predictions, ground_truth), axis=1)

# 2) cosine distances

# highest sim = 

cosine_distances  = 1. - cosine_sims



# # Subtract the two vectors
# difference = tf.subtract(predictions, ground_truth)

# # Square the differences
# squared_difference = tf.square(difference)

# # Sum the squared differences
# sum_squared_difference = tf.reduce_sum(squared_difference)

# # Take the square root to get the Euclidean distance
# euclidean_distance = tf.sqrt(sum_squared_difference)

# Start a session to run the computation
with tf.Session() as sess:
    # Run the operation to compute the distance
    cosine_dist = sess.run(cosine_distances)
    print("cosine_dist: ", cosine_dist)
