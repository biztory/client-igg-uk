# client-igg-uk

## Getting Started

### Prerequisites

- Python 3.9 or higher
- Access to an AWS S3 bucket
- A Snowflake account with required permissions
- Microsoft Dev Containers extension for Visual Studio Code (for local development)

### Installation

1. **Set Up a Virtual Environment** (Optional):
   ```bash
   python -m venv venv
   source venv/bin/activate  # For Unix or macOS
   venv\Scripts\activate  # For Windows
   ```

2. **Install Dependencies**:
   ```bash
   pip install -r requirements.txt
   ```

### Configuration

1. **Create a `.env` File**: 
   This file should contain your AWS and Snowflake credentials. Create a `.env` file in the root directory and add the following content:

   ```plaintext
   AWS_ACCESS_KEY_ID=your_access_key
   AWS_SECRET_ACCESS_KEY=your_secret_key
   S3_BUCKET_NAME=your_bucket_name
   SNOWFLAKE_USER=your_user
   SNOWFLAKE_PASSWORD=your_password
   SNOWFLAKE_ACCOUNT=your_account
   ```

   Replace the placeholders with your actual AWS and Snowflake credentials.

2. **Utilize the Dev Container**: 
   If you're using Visual Studio Code with the Microsoft Dev Containers extension, you can easily set up a development environment that matches the project's settings. It will automatically install any requirements in the requirements.txt file.

