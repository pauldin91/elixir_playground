# File Upload and Download Utility

This is a complete Phoenix LiveView file upload and download utility with the following features:

## Features
- Multi-file upload with drag & drop support
- Transaction-based file management with UUID
- Metadata storage (JSON format)
- File size formatting and validation
- ZIP download of entire transactions
- Transaction listing and management
- Delete transactions functionality

## Files Structure

1. **uploads_context.txt** - Main business logic module (Demo.Uploads)
   - Creates unique transaction IDs
   - Saves files and metadata
   - Lists all transactions
   - Handles file downloads and ZIP creation
   - Manages transaction deletion

2. **file_upload_live.txt** - Upload interface (DemoWeb.FileUploadLive)
   - Drag & drop file upload
   - Progress tracking
   - File validation (size, count)
   - Async processing simulation
   - Success feedback with transaction ID

3. **file_download_live.txt** - Download interface (DemoWeb.FileDownloadLive)
   - Lists all transactions
   - Shows file metadata
   - Download and delete buttons
   - Transaction management

4. **download_controller.txt** - HTTP download handler (DemoWeb.DownloadController)
   - Serves ZIP files for transactions
   - Proper content headers
   - Error handling

5. **router.txt** - Route configuration
   - /upload - Upload interface
   - /download - Download interface  
   - /download/:transaction_id - ZIP download endpoint

## Key Features

### Upload Process
1. User selects files via drag & drop or file picker
2. System creates unique transaction ID (UUID)
3. Files are saved to priv/uploads/{transaction_id}/
4. Metadata is saved as JSON with file info
5. User gets transaction ID for future reference

### Download Process
1. User can view all transactions
2. Each transaction shows files and metadata
3. Download icon creates ZIP of entire transaction
4. Individual file downloads also supported

### File Management
- Files organized by transaction ID
- Metadata includes timestamps, file sizes, content types
- Easy transaction deletion
- ZIP creation using Erlang's :zip module

## Dependencies Required
- Phoenix LiveView
- Jason (JSON encoding)
- UUID (transaction IDs)

## Usage
1. Navigate to /upload to upload files
2. Navigate to /download to view and download transactions
3. Click download icon to get ZIP of transaction
4. Click trash icon to delete transaction

This utility provides a complete file management system with transaction-based organization and easy download capabilities.