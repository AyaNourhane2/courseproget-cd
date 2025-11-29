#!/bin/bash
echo "🔧 Checking static files configuration..."

# Check if staticfiles directory exists
if [ ! -d "staticfiles" ]; then
    echo "📁 Creating staticfiles directory..."
    mkdir -p staticfiles
fi

# Try collectstatic with different options
echo "🔄 Testing collectstatic..."
python manage.py collectstatic --noinput --clear
STATUS=$?

if [ $STATUS -eq 0 ]; then
    echo "✅ Collectstatic successful!"
else
    echo "⚠️ Collectstatic had issues, trying without --clear..."
    python manage.py collectstatic --noinput
fi

echo "📊 Static files status:"
ls -la staticfiles/ | head -10