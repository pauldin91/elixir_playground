# File Upload System

A Phoenix LiveView-based multi-file upload system with transaction-based downloads.

## Features

- **Multi-file upload**: Upload up to 10 files simultaneously (max 50MB each)
- **Real-time progress**: Live upload progress tracking
- **Transaction-based**: Each upload gets a unique UUID transaction ID
- **Metadata extraction**: Captures file count, timestamps, filenames, and file sizes
- **Async downloads**: Download files later using the transaction ID

## Usage

### Upload Files
1. Visit `/upload`
2. Drag and drop files or click to browse
3. Upload files and receive a transaction ID
4. Save the transaction ID for later downloads

### Download Files
1. Visit `/download`
2. Enter your transaction ID
3. View file metadata and download individual files

## API Endpoints

- `GET /upload` - File upload interface
- `GET /download` - File download interface  
- `GET /download/:transaction_id/:filename` - Download specific file

## File Structure

```
priv/uploads/
├── [transaction-id-1]/
│   ├── metadata.json
│   ├── file1.pdf
│   └── file2.jpg
└── [transaction-id-2]/
    ├── metadata.json
    └── document.docx
```

## Metadata Format

```json
{
  "transaction_id": "uuid-string",
  "timestamp": "2024-01-01T12:00:00Z",
  "file_count": 2,
  "files": [
    {
      "filename": "document.pdf",
      "size": 1024000,
      "content_type": "application/pdf"
    }
  ]
}
```

## Configuration

- Max files per upload: 10
- Max file size: 50MB
- Upload directory: `priv/uploads/`
- Accepted file types: Any