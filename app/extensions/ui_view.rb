class UIView
  def on_swipe_left(enable_interaction=true, &proc)
    on_swipe(enable_interaction, UISwipeGestureRecognizerDirectionLeft, &proc)
  end

  def on_swipe_right(enable_interaction=true, &proc)
    on_swipe(enable_interaction, UISwipeGestureRecognizerDirectionRight, &proc)
  end

  private

  def on_swipe(enable_interaction, direction, &proc)
    swipe = UISwipeGestureRecognizer.alloc.initWithTarget(self, action: 'handle_gesture:')
    swipe.direction = direction
    add_gesture_recognizer_helper(swipe, enable_interaction, proc)
  end
end