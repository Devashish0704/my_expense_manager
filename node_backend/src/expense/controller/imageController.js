const pool = require("../../../db");
const queries = require("../queries");

// Upload or Update Image
const uploadOrUpdateImage = async (req, res) => {
  const { userId, base64Image } = req.body;

  if (!userId || !base64Image) {
    return res.status(400).json({ error: 'UserId and base64Image are required' });
  }

  try {
    const result = await pool.query(
      queries.upProfilePic,
      [userId, base64Image]
    );

    res.status(200).json({ message: 'Profile image uploaded/updated successfully' });
  } catch (error) {
    console.error('Error uploading/updating profile image:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

// Get Image
const getImage = async (req, res) => {
  const { userId } = req.params;

  if (!userId) {
    return res.status(400).json({ error: 'UserId is required' });
  }

  try {
    const result = await pool.query(queries.getProfilePic, [userId]);

    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'User not found' });
    }

    res.status(200).json({ profile_image: result.rows[0].profile_image });
  } catch (error) {
    console.error('Error getting profile image:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

// Delete Image
const deleteImage = async (req, res) => {
  const { userId } = req.params;

  if (!userId) {
    return res.status(400).json({ error: 'UserId is required' });
  }

  try {
    const result = await pool.query(queries.deleteProfilePic, [userId]);

    if (result.rowCount === 0) {
      return res.status(404).json({ error: 'User not found' });
    }

    res.status(200).json({ message: 'Profile image deleted successfully' });
  } catch (error) {
    console.error('Error deleting profile image:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

module.exports = {
  uploadOrUpdateImage,
  getImage,
  deleteImage,
};
